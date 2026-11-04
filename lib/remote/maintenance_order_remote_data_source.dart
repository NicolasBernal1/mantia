import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mantia/core/app_exception.dart';
import 'package:mantia/core/order_rules.dart';
import 'package:mantia/models/maintenance_order.dart';
import 'package:mantia/models/order_status.dart';
import 'package:mantia/models/user_profile.dart';

class MaintenanceOrderRemoteDataSource {
  final FirebaseFirestore firestore;

  MaintenanceOrderRemoteDataSource(this.firestore);

  CollectionReference<Map<String, dynamic>> get _orders =>
      firestore.collection('orders');

  CollectionReference<Map<String, dynamic>> get _assets =>
      firestore.collection('assets');

  String _now() => DateTime.now().toIso8601String();

  Future<List<MaintenanceOrder>> getOrders(UserProfile profile) async {
    Query<Map<String, dynamic>> query = _orders;
    if (profile.role == UserRole.requester) {
      query = query.where('requester_uid', isEqualTo: profile.uid);
    }
    if (profile.role == UserRole.technician) {
      query = query.where('technician_uid', isEqualTo: profile.uid);
    }

    final snapshot = await query.get(const GetOptions(source: Source.server));
    return snapshot.docs
        .map((doc) => MaintenanceOrder.fromJson(doc.data()))
        .toList();
  }

  Future<MaintenanceOrder?> getOrder(String orderId) async {
    final snapshot = await _orders
        .doc(orderId)
        .get(const GetOptions(source: Source.server));
    final data = snapshot.data();
    return data == null ? null : MaintenanceOrder.fromJson(data);
  }

  Future<Set<String>> getOccupiedAssetIds() async {
    final snapshot = await _assets.get(const GetOptions(source: Source.server));
    return snapshot.docs
        .where((doc) => doc.data()['active_order_id'] != null)
        .map((doc) => doc.id)
        .toSet();
  }

  Future<void> sendRequest(MaintenanceOrder order) {
    final orderRef = _orders.doc(order.id);

    return firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(orderRef);
      final serverData = snapshot.data();

      if (serverData == null) {
        transaction.set(orderRef, order.toJson());
        return;
      }

      final serverStatus = serverData['status'] as String;
      final sameDescription = serverData['description'] == order.description;

      if (serverStatus == OrderStatus.requested) {
        if (!sameDescription) {
          transaction.update(orderRef, {
            'description': order.description,
            'updated_at': _now(),
          });
        }
        return;
      }

      if (!sameDescription) {
        throw AppException(
          'La orden ya fue procesada (${OrderStatus.label(serverStatus)}); '
          'tu edición no se aplicó.',
        );
      }
    });
  }

  Future<void> authorize({
    required String orderId,
    required String priority,
    required UserProfile technician,
  }) {
    final orderRef = _orders.doc(orderId);

    return firestore.runTransaction((transaction) async {
      final orderSnapshot = await transaction.get(orderRef);
      final orderData = orderSnapshot.data();
      if (orderData == null) {
        throw const AppException(
          'La orden aún no existe en el servidor. El solicitante debe sincronizarla primero.',
        );
      }
      final status = orderData['status'] as String;
      if (status != OrderStatus.requested) {
        throw AppException(
          'La orden ya no está Solicitada (ahora: ${OrderStatus.label(status)}). Vuelve a consultar.',
        );
      }

      final assetRef = _assets.doc(orderData['assetId'] as String);
      final assetSnapshot = await transaction.get(assetRef);
      if (assetSnapshot.data()?['active_order_id'] != null) {
        throw const AppException(
          'El activo ya tiene una orden activa. No se puede autorizar una segunda orden.',
        );
      }

      transaction.update(orderRef, {
        'status': OrderStatus.authorized,
        'priority': priority,
        'technicianUid': technician.uid,
        'technicianName': technician.displayName,
        'updated_at': _now(),
      });
      transaction.set(assetRef, {
        'active_order_d': orderId,
        'updated_at': _now(),
      });
    });
  }

  Future<void> reject({required String orderId, required String reason}) {
    final orderRef = _orders.doc(orderId);

    return firestore.runTransaction((transaction) async {
      final orderSnapshot = await transaction.get(orderRef);
      final orderData = orderSnapshot.data();
      if (orderData == null) {
        throw const AppException('La orden no existe en el servidor.');
      }
      final order = MaintenanceOrder.fromJson(orderData);

      final canReject =
          order.status == OrderStatus.requested ||
          (order.status == OrderStatus.diagnosed && order.isOverBudget);
      if (!canReject) {
        throw AppException(
          'No se puede rechazar una orden en estado ${OrderStatus.label(order.status)}.',
        );
      }

      final assetRef = _assets.doc(order.assetId);
      var releasesAsset = false;
      if (order.status == OrderStatus.diagnosed) {
        final assetSnapshot = await transaction.get(assetRef);
        releasesAsset = assetSnapshot.data()?['active_order_id'] == orderId;
      }

      transaction.update(orderRef, {
        'status': OrderStatus.rejected,
        'rejectionReason': reason.trim(),
        'updated_at': _now(),
      });
      if (releasesAsset) {
        transaction.set(assetRef, {'active_order_id': null, 'updated_at': _now()});
      }
    });
  }

  Future<void> close({required String orderId, required String result}) {
    final orderRef = _orders.doc(orderId);

    return firestore.runTransaction((transaction) async {
      final orderSnapshot = await transaction.get(orderRef);
      final orderData = orderSnapshot.data();
      if (orderData == null) {
        throw const AppException('La orden no existe en el servidor.');
      }
      final status = orderData['status'] as String;
      if (status != OrderStatus.finished) {
        throw AppException(
          'Solo se puede cerrar una orden Terminada (ahora: ${OrderStatus.label(status)}).',
        );
      }

      final assetRef = _assets.doc(orderData['assetId'] as String);
      final assetSnapshot = await transaction.get(assetRef);
      final holdsAsset = assetSnapshot.data()?['active_order_id'] == orderId;

      transaction.update(orderRef, {
        'status': OrderStatus.closed,
        'closeResult': result.trim(),
        'updated_at': _now(),
      });
      if (holdsAsset) {
        transaction.set(assetRef, {'active_order_id': null, 'updated_at': _now()});
      }
    });
  }

  Future<void> registerDiagnosis({
    required String orderId,
    required String technicianUid,
    required String cause,
    required int cost,
  }) {
    final orderRef = _orders.doc(orderId);

    return firestore.runTransaction((transaction) async {
      final order = await _getAssignedOrder(
        transaction,
        orderRef,
        technicianUid,
      );
      if (order.status != OrderStatus.authorized) {
        throw AppException(
          'Solo se diagnostica una orden Autorizada (ahora: ${OrderStatus.label(order.status)}).',
        );
      }
      transaction.update(orderRef, {
        'status': OrderStatus.diagnosed,
        'diagnosisCause': cause.trim(),
        'estimatedCost': cost,
        'updated_at': _now(),
      });
    });
  }

  Future<void> startRepair({
    required String orderId,
    required String technicianUid,
  }) {
    final orderRef = _orders.doc(orderId);

    return firestore.runTransaction((transaction) async {
      final order = await _getAssignedOrder(
        transaction,
        orderRef,
        technicianUid,
      );
      final problem = OrderRules.checkCanStartRepair(order);
      if (problem != null) throw AppException(problem);

      transaction.update(orderRef, {
        'status': OrderStatus.inRepair,
        'updated_at': _now(),
      });
    });
  }

  Future<void> finishRepair({
    required String orderId,
    required String technicianUid,
  }) {
    final orderRef = _orders.doc(orderId);

    return firestore.runTransaction((transaction) async {
      final order = await _getAssignedOrder(
        transaction,
        orderRef,
        technicianUid,
      );
      if (order.status != OrderStatus.inRepair) {
        throw AppException(
          'Solo se termina una orden En reparación (ahora: ${OrderStatus.label(order.status)}).',
        );
      }
      transaction.update(orderRef, {
        'status': OrderStatus.finished,
        'updated_at': _now(),
      });
    });
  }

  Future<MaintenanceOrder> _getAssignedOrder(
    Transaction transaction,
    DocumentReference<Map<String, dynamic>> orderRef,
    String technicianUid,
  ) async {
    final snapshot = await transaction.get(orderRef);
    final data = snapshot.data();
    if (data == null) {
      throw const AppException('La orden no existe en el servidor.');
    }
    final order = MaintenanceOrder.fromJson(data);
    if (order.technicianUid != technicianUid) {
      throw const AppException(
        'Solo el técnico asignado puede registrar diagnóstico y reparación.',
      );
    }
    return order;
  }
}
