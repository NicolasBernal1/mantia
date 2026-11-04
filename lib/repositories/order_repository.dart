import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:mantia/core/app_exception.dart';
import 'package:mantia/core/app_logger.dart';
import 'package:mantia/core/id_generator.dart';
import 'package:mantia/core/order_rules.dart';
import 'package:mantia/local/maintenance_order_local_data_source.dart';
import 'package:mantia/models/maintenance_order.dart';
import 'package:mantia/models/office_asset.dart';
import 'package:mantia/models/order_status.dart';
import 'package:mantia/models/user_profile.dart';
import 'package:mantia/remote/maintenance_order_remote_data_source.dart';

class OrderRepository {
  final MaintenanceOrderLocalDataSource local;
  final MaintenanceOrderRemoteDataSource remote;

  final Set<String> _ordersBeingSent = {};

  OrderRepository({required this.local, required this.remote});

  Future<List<MaintenanceOrder>> getOrders(UserProfile profile) async {
    final orders = await local.getOrders(profile.uid);

    return orders.where((order) {
      if (profile.role == UserRole.requester) {
        return order.requesterUid == profile.uid;
      }
      if (profile.role == UserRole.technician) {
        return order.technicianUid == profile.uid;
      }
      return true;
    }).toList();
  }

  Future<MaintenanceOrder?> getOrder(String ownerUid, String orderId) =>
      local.getOrder(ownerUid, orderId);

  Future<void> createRequest({
    required UserProfile profile,
    required OfficeAsset asset,
    required String description,
  }) async {
    final problem = OrderRules.validateDescription(description);
    if (problem != null) throw AppException(problem);

    final now = DateTime.now();
    final order = MaintenanceOrder(
      id: newOrderId(),
      assetId: asset.id,
      assetName: asset.name,
      assetCode: asset.internalCode,
      description: description.trim(),
      requesterUid: profile.uid,
      requesterName: profile.displayName,
      status: OrderStatus.requested,
      createdAt: now,
      updatedAt: now,
      pendingSync: true,
    );

    await local.saveNewOrder(profile.uid, order);
    unawaited(sendOrder(profile.uid, order.id));
  }

  Future<void> editDescription({
    required String ownerUid,
    required String orderId,
    required String description,
  }) async {
    final problem = OrderRules.validateDescription(description);
    if (problem != null) throw AppException(problem);

    final order = await local.getOrder(ownerUid, orderId);
    if (order == null) throw const AppException('La solicitud ya no existe.');
    if (order.status != OrderStatus.requested) {
      throw const AppException(
        'Solo se puede editar una solicitud en estado Solicitada.',
      );
    }

    await local.updateDescription(ownerUid, orderId, description.trim());
    unawaited(sendOrder(ownerUid, orderId));
  }

  Future<void> sendOrder(String ownerUid, String orderId) async {
    final key = '$ownerUid/$orderId';
    if (!_ordersBeingSent.add(key)) return;

    try {
      final order = await local.getOrder(ownerUid, orderId);
      if (order == null || !order.pendingSync) return;

      final sentVersion = order.localVersion;
      try {
        await remote.sendRequest(order);
        await local.markSynced(ownerUid, orderId, sentVersion);
      } on AppException catch (error) {
        await local.saveSyncError(
          ownerUid,
          orderId,
          sentVersion,
          error.message,
        );
      } on FirebaseException catch (error, stackTrace) {
        AppLogger.error(
          'No se pudo enviar la orden $orderId',
          error,
          stackTrace,
        );
        await local.saveSyncError(
          ownerUid,
          orderId,
          sentVersion,
          _serverErrorMessage(error),
        );
      }
    } finally {
      _ordersBeingSent.remove(key);
    }
  }

  Future<int> syncPending(String ownerUid) async {
    final pendingOrders = await local.getPendingOrders(ownerUid);
    for (final order in pendingOrders) {
      await sendOrder(ownerUid, order.id);
    }
    return (await local.getPendingOrders(ownerUid)).length;
  }

  Future<int> syncWithServer(UserProfile profile) async {
    await syncPending(profile.uid);

    try {
      final serverOrders = await remote.getOrders(profile);
      for (final order in serverOrders) {
        await local.upsertFromServer(profile.uid, order);
      }
    } on FirebaseException catch (error, stackTrace) {
      AppLogger.error('No se pudo leer del servidor', error, stackTrace);
      throw AppException(_serverErrorMessage(error));
    }

    return (await local.getPendingOrders(profile.uid)).length;
  }

  Future<void> discardLocalChange(String ownerUid, String orderId) async {
    await local.deleteOrder(ownerUid, orderId);
    try {
      final serverOrder = await remote.getOrder(orderId);
      if (serverOrder != null) {
        await local.upsertFromServer(ownerUid, serverOrder);
      }
    } catch (error, stackTrace) {
      AppLogger.error(
        'No se pudo refrescar la orden $orderId',
        error,
        stackTrace,
      );
    }
  }

  Future<void> authorize({
    required UserProfile profile,
    required String orderId,
    required String priority,
    required UserProfile technician,
  }) async {
    _requireRole(profile, UserRole.supervisor);
    await _runOnServer(
      () => remote.authorize(
        orderId: orderId,
        priority: priority,
        technician: technician,
      ),
    );
    await _refreshOrder(profile.uid, orderId);
  }

  Future<void> reject({
    required UserProfile profile,
    required String orderId,
    required String reason,
  }) async {
    _requireRole(profile, UserRole.supervisor);
    final problem = OrderRules.validateRejectionReason(reason);
    if (problem != null) throw AppException(problem);

    await _runOnServer(() => remote.reject(orderId: orderId, reason: reason));
    await _refreshOrder(profile.uid, orderId);
  }

  Future<void> close({
    required UserProfile profile,
    required String orderId,
    required String result,
  }) async {
    _requireRole(profile, UserRole.supervisor);
    final problem = OrderRules.validateCloseResult(result);
    if (problem != null) throw AppException(problem);

    await _runOnServer(() => remote.close(orderId: orderId, result: result));
    await _refreshOrder(profile.uid, orderId);
  }

  Future<void> registerDiagnosis({
    required UserProfile profile,
    required String orderId,
    required String cause,
    required int? cost,
  }) async {
    _requireRole(profile, UserRole.technician);
    final problem = OrderRules.validateDiagnosis(cause, cost);
    if (problem != null) throw AppException(problem);

    await _runOnServer(
      () => remote.registerDiagnosis(
        orderId: orderId,
        technicianUid: profile.uid,
        cause: cause,
        cost: cost!,
      ),
    );
    await _refreshOrder(profile.uid, orderId);
  }

  Future<void> startRepair({
    required UserProfile profile,
    required String orderId,
  }) async {
    _requireRole(profile, UserRole.technician);
    await _runOnServer(
      () => remote.startRepair(orderId: orderId, technicianUid: profile.uid),
    );
    await _refreshOrder(profile.uid, orderId);
  }

  Future<void> finishRepair({
    required UserProfile profile,
    required String orderId,
  }) async {
    _requireRole(profile, UserRole.technician);
    await _runOnServer(
      () => remote.finishRepair(orderId: orderId, technicianUid: profile.uid),
    );
    await _refreshOrder(profile.uid, orderId);
  }

  void _requireRole(UserProfile profile, String role) {
    if (profile.role != role) {
      throw const AppException('Tu rol no permite realizar esta acción.');
    }
  }

  Future<void> _runOnServer(Future<void> Function() action) async {
    try {
      await action();
    } on FirebaseException catch (error, stackTrace) {
      AppLogger.error('Fallo la operación en el servidor', error, stackTrace);
      throw AppException(_serverErrorMessage(error));
    }
  }

  String _serverErrorMessage(FirebaseException error) {
    switch (error.code) {
      case 'unavailable':
      case 'deadline-exceeded':
        return 'Sin conexión con el servidor. Revisa tu Internet e inténtalo de nuevo.';
      case 'permission-denied':
        return 'El servidor rechazó la operación por las reglas de seguridad.';
      case 'aborted':
        return 'Otra cuenta modificó el mismo registro. Vuelve a consultar e inténtalo de nuevo.';
      default:
        return 'No se pudo completar la operación con el servidor.';
    }
  }

  Future<void> _refreshOrder(String ownerUid, String orderId) async {
    try {
      final serverOrder = await remote.getOrder(orderId);
      if (serverOrder != null) {
        await local.upsertFromServer(ownerUid, serverOrder);
      }
    } catch (error, stackTrace) {
      AppLogger.error(
        'No se pudo refrescar la orden $orderId',
        error,
        stackTrace,
      );
    }
  }
}
