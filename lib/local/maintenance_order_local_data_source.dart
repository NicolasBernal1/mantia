import 'package:drift/drift.dart';
import 'package:mantia/local/app_database.dart';
import 'package:mantia/models/maintenance_order.dart';

class MaintenanceOrderLocalDataSource {
  final AppDatabase db;

  MaintenanceOrderLocalDataSource(this.db);

  MaintenanceOrder _toDomain(MaintenanceOrderRow row) {
    return MaintenanceOrder(
      id: row.orderId,
      assetId: row.assetId,
      assetName: row.assetName,
      assetCode: row.assetCode,
      description: row.description,
      requesterUid: row.requesterUid,
      requesterName: row.requesterName,
      status: row.status,
      priority: row.priority,
      technicianUid: row.technicianUid,
      technicianName: row.technicianName,
      diagnosisCause: row.diagnosisCause,
      estimatedCost: row.estimatedCost,
      closeResult: row.closeResult,
      rejectionReason: row.rejectionReason,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      pendingSync: row.pendingSync,
      syncError: row.syncError,
      localVersion: row.localVersion,
    );
  }

  MaintenanceOrdersCompanion _toCompanion(
    String ownerUid,
    MaintenanceOrder order,
  ) {
    return MaintenanceOrdersCompanion.insert(
      ownerUid: ownerUid,
      orderId: order.id,
      assetId: order.assetId,
      assetName: order.assetName,
      assetCode: order.assetCode,
      description: order.description,
      requesterUid: order.requesterUid,
      requesterName: order.requesterName,
      status: order.status,
      createdAt: order.createdAt,
      updatedAt: order.updatedAt,
      priority: Value(order.priority),
      technicianUid: Value(order.technicianUid),
      technicianName: Value(order.technicianName),
      diagnosisCause: Value(order.diagnosisCause),
      estimatedCost: Value(order.estimatedCost),
      closeResult: Value(order.closeResult),
      rejectionReason: Value(order.rejectionReason),
      pendingSync: Value(order.pendingSync),
      syncError: Value(order.syncError),
      localVersion: Value(order.localVersion),
    );
  }

  Future<MaintenanceOrderRow?> _getRow(String ownerUid, String orderId) {
    final query = db.select(db.maintenanceOrders)
      ..where((t) => t.ownerUid.equals(ownerUid) & t.orderId.equals(orderId));
    return query.getSingleOrNull();
  }

  Future<List<MaintenanceOrder>> getOrders(String ownerUid) async {
    final query = db.select(db.maintenanceOrders)
      ..where((t) => t.ownerUid.equals(ownerUid))
      ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]);
    final rows = await query.get();
    return rows.map(_toDomain).toList();
  }

  Future<MaintenanceOrder?> getOrder(String ownerUid, String orderId) async {
    final row = await _getRow(ownerUid, orderId);
    return row == null ? null : _toDomain(row);
  }

  Future<void> saveNewOrder(String ownerUid, MaintenanceOrder order) async {
    await db.into(db.maintenanceOrders).insert(_toCompanion(ownerUid, order));
  }

  Future<void> updateDescription(
    String ownerUid,
    String orderId,
    String description,
  ) async {
    final row = await _getRow(ownerUid, orderId);
    if (row == null) return;

    await (db.update(db.maintenanceOrders)..where(
          (t) => t.ownerUid.equals(ownerUid) & t.orderId.equals(orderId),
        ))
        .write(
          MaintenanceOrdersCompanion(
            description: Value(description),
            updatedAt: Value(DateTime.now()),
            pendingSync: const Value(true),
            syncError: const Value<String?>(null),
            localVersion: Value(row.localVersion + 1),
          ),
        );
  }

  Future<List<MaintenanceOrder>> getPendingOrders(String ownerUid) async {
    final rows =
        await (db.select(db.maintenanceOrders)..where(
              (t) => t.ownerUid.equals(ownerUid) & t.pendingSync.equals(true),
            ))
            .get();

    return rows.map(_toDomain).toList();
  }

  Future<void> markSynced(
    String ownerUid,
    String orderId,
    int sentVersion,
  ) async {
    await (db.update(db.maintenanceOrders)..where(
          (t) =>
              t.ownerUid.equals(ownerUid) &
              t.orderId.equals(orderId) &
              t.localVersion.equals(sentVersion),
        ))
        .write(
          const MaintenanceOrdersCompanion(
            pendingSync: Value(false),
            syncError: Value<String?>(null),
          ),
        );
  }

  Future<void> saveSyncError(
    String ownerUid,
    String orderId,
    int sentVersion,
    String message,
  ) async {
    await (db.update(db.maintenanceOrders)..where(
          (t) =>
              t.ownerUid.equals(ownerUid) &
              t.orderId.equals(orderId) &
              t.localVersion.equals(sentVersion),
        ))
        .write(MaintenanceOrdersCompanion(syncError: Value(message)));
  }

  Future<void> upsertFromServer(String ownerUid, MaintenanceOrder order) async {
    final row = await _getRow(ownerUid, order.id);
    if (row != null && row.pendingSync) return;

    await db
        .into(db.maintenanceOrders)
        .insertOnConflictUpdate(_toCompanion(ownerUid, order));
  }

  Future<void> deleteOrder(String ownerUid, String orderId) async {
    await (db.delete(db.maintenanceOrders)..where(
          (t) => t.ownerUid.equals(ownerUid) & t.orderId.equals(orderId),
        ))
        .go();
  }
}
