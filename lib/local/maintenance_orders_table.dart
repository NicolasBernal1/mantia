import 'package:drift/drift.dart';

@DataClassName('MaintenanceOrderRow')
class MaintenanceOrders extends Table {
  TextColumn get ownerUid => text()();
  TextColumn get orderId => text()();

  TextColumn get assetId => text()();
  TextColumn get assetName => text()();
  TextColumn get assetCode => text()();
  TextColumn get description => text()();
  TextColumn get requesterUid => text()();
  TextColumn get requesterName => text()();
  TextColumn get status => text()();
  TextColumn get priority => text().nullable()();
  TextColumn get technicianUid => text().nullable()();
  TextColumn get technicianName => text().nullable()();
  TextColumn get diagnosisCause => text().nullable()();
  IntColumn get estimatedCost => integer().nullable()();
  TextColumn get closeResult => text().nullable()();
  TextColumn get rejectionReason => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  BoolColumn get pendingSync => boolean().withDefault(const Constant(false))();
  TextColumn get syncError => text().nullable()();
  IntColumn get localVersion => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {ownerUid, orderId};
}
