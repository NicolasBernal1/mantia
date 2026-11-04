// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $MaintenanceOrdersTable extends MaintenanceOrders
    with TableInfo<$MaintenanceOrdersTable, MaintenanceOrderRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MaintenanceOrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _ownerUidMeta = const VerificationMeta(
    'ownerUid',
  );
  @override
  late final GeneratedColumn<String> ownerUid = GeneratedColumn<String>(
    'owner_uid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _assetIdMeta = const VerificationMeta(
    'assetId',
  );
  @override
  late final GeneratedColumn<String> assetId = GeneratedColumn<String>(
    'asset_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _assetNameMeta = const VerificationMeta(
    'assetName',
  );
  @override
  late final GeneratedColumn<String> assetName = GeneratedColumn<String>(
    'asset_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _assetCodeMeta = const VerificationMeta(
    'assetCode',
  );
  @override
  late final GeneratedColumn<String> assetCode = GeneratedColumn<String>(
    'asset_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _requesterUidMeta = const VerificationMeta(
    'requesterUid',
  );
  @override
  late final GeneratedColumn<String> requesterUid = GeneratedColumn<String>(
    'requester_uid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _requesterNameMeta = const VerificationMeta(
    'requesterName',
  );
  @override
  late final GeneratedColumn<String> requesterName = GeneratedColumn<String>(
    'requester_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
    'priority',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _technicianUidMeta = const VerificationMeta(
    'technicianUid',
  );
  @override
  late final GeneratedColumn<String> technicianUid = GeneratedColumn<String>(
    'technician_uid',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _technicianNameMeta = const VerificationMeta(
    'technicianName',
  );
  @override
  late final GeneratedColumn<String> technicianName = GeneratedColumn<String>(
    'technician_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _diagnosisCauseMeta = const VerificationMeta(
    'diagnosisCause',
  );
  @override
  late final GeneratedColumn<String> diagnosisCause = GeneratedColumn<String>(
    'diagnosis_cause',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _estimatedCostMeta = const VerificationMeta(
    'estimatedCost',
  );
  @override
  late final GeneratedColumn<int> estimatedCost = GeneratedColumn<int>(
    'estimated_cost',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _closeResultMeta = const VerificationMeta(
    'closeResult',
  );
  @override
  late final GeneratedColumn<String> closeResult = GeneratedColumn<String>(
    'close_result',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rejectionReasonMeta = const VerificationMeta(
    'rejectionReason',
  );
  @override
  late final GeneratedColumn<String> rejectionReason = GeneratedColumn<String>(
    'rejection_reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pendingSyncMeta = const VerificationMeta(
    'pendingSync',
  );
  @override
  late final GeneratedColumn<bool> pendingSync = GeneratedColumn<bool>(
    'pending_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pending_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _syncErrorMeta = const VerificationMeta(
    'syncError',
  );
  @override
  late final GeneratedColumn<String> syncError = GeneratedColumn<String>(
    'sync_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localVersionMeta = const VerificationMeta(
    'localVersion',
  );
  @override
  late final GeneratedColumn<int> localVersion = GeneratedColumn<int>(
    'local_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  @override
  List<GeneratedColumn> get $columns => [
    ownerUid,
    orderId,
    assetId,
    assetName,
    assetCode,
    description,
    requesterUid,
    requesterName,
    status,
    priority,
    technicianUid,
    technicianName,
    diagnosisCause,
    estimatedCost,
    closeResult,
    rejectionReason,
    createdAt,
    updatedAt,
    pendingSync,
    syncError,
    localVersion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'maintenance_orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<MaintenanceOrderRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('owner_uid')) {
      context.handle(
        _ownerUidMeta,
        ownerUid.isAcceptableOrUnknown(data['owner_uid']!, _ownerUidMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerUidMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('asset_id')) {
      context.handle(
        _assetIdMeta,
        assetId.isAcceptableOrUnknown(data['asset_id']!, _assetIdMeta),
      );
    } else if (isInserting) {
      context.missing(_assetIdMeta);
    }
    if (data.containsKey('asset_name')) {
      context.handle(
        _assetNameMeta,
        assetName.isAcceptableOrUnknown(data['asset_name']!, _assetNameMeta),
      );
    } else if (isInserting) {
      context.missing(_assetNameMeta);
    }
    if (data.containsKey('asset_code')) {
      context.handle(
        _assetCodeMeta,
        assetCode.isAcceptableOrUnknown(data['asset_code']!, _assetCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_assetCodeMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('requester_uid')) {
      context.handle(
        _requesterUidMeta,
        requesterUid.isAcceptableOrUnknown(
          data['requester_uid']!,
          _requesterUidMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_requesterUidMeta);
    }
    if (data.containsKey('requester_name')) {
      context.handle(
        _requesterNameMeta,
        requesterName.isAcceptableOrUnknown(
          data['requester_name']!,
          _requesterNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_requesterNameMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('technician_uid')) {
      context.handle(
        _technicianUidMeta,
        technicianUid.isAcceptableOrUnknown(
          data['technician_uid']!,
          _technicianUidMeta,
        ),
      );
    }
    if (data.containsKey('technician_name')) {
      context.handle(
        _technicianNameMeta,
        technicianName.isAcceptableOrUnknown(
          data['technician_name']!,
          _technicianNameMeta,
        ),
      );
    }
    if (data.containsKey('diagnosis_cause')) {
      context.handle(
        _diagnosisCauseMeta,
        diagnosisCause.isAcceptableOrUnknown(
          data['diagnosis_cause']!,
          _diagnosisCauseMeta,
        ),
      );
    }
    if (data.containsKey('estimated_cost')) {
      context.handle(
        _estimatedCostMeta,
        estimatedCost.isAcceptableOrUnknown(
          data['estimated_cost']!,
          _estimatedCostMeta,
        ),
      );
    }
    if (data.containsKey('close_result')) {
      context.handle(
        _closeResultMeta,
        closeResult.isAcceptableOrUnknown(
          data['close_result']!,
          _closeResultMeta,
        ),
      );
    }
    if (data.containsKey('rejection_reason')) {
      context.handle(
        _rejectionReasonMeta,
        rejectionReason.isAcceptableOrUnknown(
          data['rejection_reason']!,
          _rejectionReasonMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('pending_sync')) {
      context.handle(
        _pendingSyncMeta,
        pendingSync.isAcceptableOrUnknown(
          data['pending_sync']!,
          _pendingSyncMeta,
        ),
      );
    }
    if (data.containsKey('sync_error')) {
      context.handle(
        _syncErrorMeta,
        syncError.isAcceptableOrUnknown(data['sync_error']!, _syncErrorMeta),
      );
    }
    if (data.containsKey('local_version')) {
      context.handle(
        _localVersionMeta,
        localVersion.isAcceptableOrUnknown(
          data['local_version']!,
          _localVersionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {ownerUid, orderId};
  @override
  MaintenanceOrderRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MaintenanceOrderRow(
      ownerUid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_uid'],
      )!,
      orderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_id'],
      )!,
      assetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}asset_id'],
      )!,
      assetName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}asset_name'],
      )!,
      assetCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}asset_code'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      requesterUid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}requester_uid'],
      )!,
      requesterName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}requester_name'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}priority'],
      ),
      technicianUid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}technician_uid'],
      ),
      technicianName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}technician_name'],
      ),
      diagnosisCause: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}diagnosis_cause'],
      ),
      estimatedCost: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}estimated_cost'],
      ),
      closeResult: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}close_result'],
      ),
      rejectionReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rejection_reason'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      pendingSync: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pending_sync'],
      )!,
      syncError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_error'],
      ),
      localVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_version'],
      )!,
    );
  }

  @override
  $MaintenanceOrdersTable createAlias(String alias) {
    return $MaintenanceOrdersTable(attachedDatabase, alias);
  }
}

class MaintenanceOrderRow extends DataClass
    implements Insertable<MaintenanceOrderRow> {
  final String ownerUid;
  final String orderId;
  final String assetId;
  final String assetName;
  final String assetCode;
  final String description;
  final String requesterUid;
  final String requesterName;
  final String status;
  final String? priority;
  final String? technicianUid;
  final String? technicianName;
  final String? diagnosisCause;
  final int? estimatedCost;
  final String? closeResult;
  final String? rejectionReason;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool pendingSync;
  final String? syncError;
  final int localVersion;
  const MaintenanceOrderRow({
    required this.ownerUid,
    required this.orderId,
    required this.assetId,
    required this.assetName,
    required this.assetCode,
    required this.description,
    required this.requesterUid,
    required this.requesterName,
    required this.status,
    this.priority,
    this.technicianUid,
    this.technicianName,
    this.diagnosisCause,
    this.estimatedCost,
    this.closeResult,
    this.rejectionReason,
    required this.createdAt,
    required this.updatedAt,
    required this.pendingSync,
    this.syncError,
    required this.localVersion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['owner_uid'] = Variable<String>(ownerUid);
    map['order_id'] = Variable<String>(orderId);
    map['asset_id'] = Variable<String>(assetId);
    map['asset_name'] = Variable<String>(assetName);
    map['asset_code'] = Variable<String>(assetCode);
    map['description'] = Variable<String>(description);
    map['requester_uid'] = Variable<String>(requesterUid);
    map['requester_name'] = Variable<String>(requesterName);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || priority != null) {
      map['priority'] = Variable<String>(priority);
    }
    if (!nullToAbsent || technicianUid != null) {
      map['technician_uid'] = Variable<String>(technicianUid);
    }
    if (!nullToAbsent || technicianName != null) {
      map['technician_name'] = Variable<String>(technicianName);
    }
    if (!nullToAbsent || diagnosisCause != null) {
      map['diagnosis_cause'] = Variable<String>(diagnosisCause);
    }
    if (!nullToAbsent || estimatedCost != null) {
      map['estimated_cost'] = Variable<int>(estimatedCost);
    }
    if (!nullToAbsent || closeResult != null) {
      map['close_result'] = Variable<String>(closeResult);
    }
    if (!nullToAbsent || rejectionReason != null) {
      map['rejection_reason'] = Variable<String>(rejectionReason);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['pending_sync'] = Variable<bool>(pendingSync);
    if (!nullToAbsent || syncError != null) {
      map['sync_error'] = Variable<String>(syncError);
    }
    map['local_version'] = Variable<int>(localVersion);
    return map;
  }

  MaintenanceOrdersCompanion toCompanion(bool nullToAbsent) {
    return MaintenanceOrdersCompanion(
      ownerUid: Value(ownerUid),
      orderId: Value(orderId),
      assetId: Value(assetId),
      assetName: Value(assetName),
      assetCode: Value(assetCode),
      description: Value(description),
      requesterUid: Value(requesterUid),
      requesterName: Value(requesterName),
      status: Value(status),
      priority: priority == null && nullToAbsent
          ? const Value.absent()
          : Value(priority),
      technicianUid: technicianUid == null && nullToAbsent
          ? const Value.absent()
          : Value(technicianUid),
      technicianName: technicianName == null && nullToAbsent
          ? const Value.absent()
          : Value(technicianName),
      diagnosisCause: diagnosisCause == null && nullToAbsent
          ? const Value.absent()
          : Value(diagnosisCause),
      estimatedCost: estimatedCost == null && nullToAbsent
          ? const Value.absent()
          : Value(estimatedCost),
      closeResult: closeResult == null && nullToAbsent
          ? const Value.absent()
          : Value(closeResult),
      rejectionReason: rejectionReason == null && nullToAbsent
          ? const Value.absent()
          : Value(rejectionReason),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      pendingSync: Value(pendingSync),
      syncError: syncError == null && nullToAbsent
          ? const Value.absent()
          : Value(syncError),
      localVersion: Value(localVersion),
    );
  }

  factory MaintenanceOrderRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MaintenanceOrderRow(
      ownerUid: serializer.fromJson<String>(json['ownerUid']),
      orderId: serializer.fromJson<String>(json['orderId']),
      assetId: serializer.fromJson<String>(json['assetId']),
      assetName: serializer.fromJson<String>(json['assetName']),
      assetCode: serializer.fromJson<String>(json['assetCode']),
      description: serializer.fromJson<String>(json['description']),
      requesterUid: serializer.fromJson<String>(json['requesterUid']),
      requesterName: serializer.fromJson<String>(json['requesterName']),
      status: serializer.fromJson<String>(json['status']),
      priority: serializer.fromJson<String?>(json['priority']),
      technicianUid: serializer.fromJson<String?>(json['technicianUid']),
      technicianName: serializer.fromJson<String?>(json['technicianName']),
      diagnosisCause: serializer.fromJson<String?>(json['diagnosisCause']),
      estimatedCost: serializer.fromJson<int?>(json['estimatedCost']),
      closeResult: serializer.fromJson<String?>(json['closeResult']),
      rejectionReason: serializer.fromJson<String?>(json['rejectionReason']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      pendingSync: serializer.fromJson<bool>(json['pendingSync']),
      syncError: serializer.fromJson<String?>(json['syncError']),
      localVersion: serializer.fromJson<int>(json['localVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'ownerUid': serializer.toJson<String>(ownerUid),
      'orderId': serializer.toJson<String>(orderId),
      'assetId': serializer.toJson<String>(assetId),
      'assetName': serializer.toJson<String>(assetName),
      'assetCode': serializer.toJson<String>(assetCode),
      'description': serializer.toJson<String>(description),
      'requesterUid': serializer.toJson<String>(requesterUid),
      'requesterName': serializer.toJson<String>(requesterName),
      'status': serializer.toJson<String>(status),
      'priority': serializer.toJson<String?>(priority),
      'technicianUid': serializer.toJson<String?>(technicianUid),
      'technicianName': serializer.toJson<String?>(technicianName),
      'diagnosisCause': serializer.toJson<String?>(diagnosisCause),
      'estimatedCost': serializer.toJson<int?>(estimatedCost),
      'closeResult': serializer.toJson<String?>(closeResult),
      'rejectionReason': serializer.toJson<String?>(rejectionReason),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'pendingSync': serializer.toJson<bool>(pendingSync),
      'syncError': serializer.toJson<String?>(syncError),
      'localVersion': serializer.toJson<int>(localVersion),
    };
  }

  MaintenanceOrderRow copyWith({
    String? ownerUid,
    String? orderId,
    String? assetId,
    String? assetName,
    String? assetCode,
    String? description,
    String? requesterUid,
    String? requesterName,
    String? status,
    Value<String?> priority = const Value.absent(),
    Value<String?> technicianUid = const Value.absent(),
    Value<String?> technicianName = const Value.absent(),
    Value<String?> diagnosisCause = const Value.absent(),
    Value<int?> estimatedCost = const Value.absent(),
    Value<String?> closeResult = const Value.absent(),
    Value<String?> rejectionReason = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? pendingSync,
    Value<String?> syncError = const Value.absent(),
    int? localVersion,
  }) => MaintenanceOrderRow(
    ownerUid: ownerUid ?? this.ownerUid,
    orderId: orderId ?? this.orderId,
    assetId: assetId ?? this.assetId,
    assetName: assetName ?? this.assetName,
    assetCode: assetCode ?? this.assetCode,
    description: description ?? this.description,
    requesterUid: requesterUid ?? this.requesterUid,
    requesterName: requesterName ?? this.requesterName,
    status: status ?? this.status,
    priority: priority.present ? priority.value : this.priority,
    technicianUid: technicianUid.present
        ? technicianUid.value
        : this.technicianUid,
    technicianName: technicianName.present
        ? technicianName.value
        : this.technicianName,
    diagnosisCause: diagnosisCause.present
        ? diagnosisCause.value
        : this.diagnosisCause,
    estimatedCost: estimatedCost.present
        ? estimatedCost.value
        : this.estimatedCost,
    closeResult: closeResult.present ? closeResult.value : this.closeResult,
    rejectionReason: rejectionReason.present
        ? rejectionReason.value
        : this.rejectionReason,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    pendingSync: pendingSync ?? this.pendingSync,
    syncError: syncError.present ? syncError.value : this.syncError,
    localVersion: localVersion ?? this.localVersion,
  );
  MaintenanceOrderRow copyWithCompanion(MaintenanceOrdersCompanion data) {
    return MaintenanceOrderRow(
      ownerUid: data.ownerUid.present ? data.ownerUid.value : this.ownerUid,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      assetId: data.assetId.present ? data.assetId.value : this.assetId,
      assetName: data.assetName.present ? data.assetName.value : this.assetName,
      assetCode: data.assetCode.present ? data.assetCode.value : this.assetCode,
      description: data.description.present
          ? data.description.value
          : this.description,
      requesterUid: data.requesterUid.present
          ? data.requesterUid.value
          : this.requesterUid,
      requesterName: data.requesterName.present
          ? data.requesterName.value
          : this.requesterName,
      status: data.status.present ? data.status.value : this.status,
      priority: data.priority.present ? data.priority.value : this.priority,
      technicianUid: data.technicianUid.present
          ? data.technicianUid.value
          : this.technicianUid,
      technicianName: data.technicianName.present
          ? data.technicianName.value
          : this.technicianName,
      diagnosisCause: data.diagnosisCause.present
          ? data.diagnosisCause.value
          : this.diagnosisCause,
      estimatedCost: data.estimatedCost.present
          ? data.estimatedCost.value
          : this.estimatedCost,
      closeResult: data.closeResult.present
          ? data.closeResult.value
          : this.closeResult,
      rejectionReason: data.rejectionReason.present
          ? data.rejectionReason.value
          : this.rejectionReason,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      pendingSync: data.pendingSync.present
          ? data.pendingSync.value
          : this.pendingSync,
      syncError: data.syncError.present ? data.syncError.value : this.syncError,
      localVersion: data.localVersion.present
          ? data.localVersion.value
          : this.localVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceOrderRow(')
          ..write('ownerUid: $ownerUid, ')
          ..write('orderId: $orderId, ')
          ..write('assetId: $assetId, ')
          ..write('assetName: $assetName, ')
          ..write('assetCode: $assetCode, ')
          ..write('description: $description, ')
          ..write('requesterUid: $requesterUid, ')
          ..write('requesterName: $requesterName, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('technicianUid: $technicianUid, ')
          ..write('technicianName: $technicianName, ')
          ..write('diagnosisCause: $diagnosisCause, ')
          ..write('estimatedCost: $estimatedCost, ')
          ..write('closeResult: $closeResult, ')
          ..write('rejectionReason: $rejectionReason, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('pendingSync: $pendingSync, ')
          ..write('syncError: $syncError, ')
          ..write('localVersion: $localVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    ownerUid,
    orderId,
    assetId,
    assetName,
    assetCode,
    description,
    requesterUid,
    requesterName,
    status,
    priority,
    technicianUid,
    technicianName,
    diagnosisCause,
    estimatedCost,
    closeResult,
    rejectionReason,
    createdAt,
    updatedAt,
    pendingSync,
    syncError,
    localVersion,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MaintenanceOrderRow &&
          other.ownerUid == this.ownerUid &&
          other.orderId == this.orderId &&
          other.assetId == this.assetId &&
          other.assetName == this.assetName &&
          other.assetCode == this.assetCode &&
          other.description == this.description &&
          other.requesterUid == this.requesterUid &&
          other.requesterName == this.requesterName &&
          other.status == this.status &&
          other.priority == this.priority &&
          other.technicianUid == this.technicianUid &&
          other.technicianName == this.technicianName &&
          other.diagnosisCause == this.diagnosisCause &&
          other.estimatedCost == this.estimatedCost &&
          other.closeResult == this.closeResult &&
          other.rejectionReason == this.rejectionReason &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.pendingSync == this.pendingSync &&
          other.syncError == this.syncError &&
          other.localVersion == this.localVersion);
}

class MaintenanceOrdersCompanion extends UpdateCompanion<MaintenanceOrderRow> {
  final Value<String> ownerUid;
  final Value<String> orderId;
  final Value<String> assetId;
  final Value<String> assetName;
  final Value<String> assetCode;
  final Value<String> description;
  final Value<String> requesterUid;
  final Value<String> requesterName;
  final Value<String> status;
  final Value<String?> priority;
  final Value<String?> technicianUid;
  final Value<String?> technicianName;
  final Value<String?> diagnosisCause;
  final Value<int?> estimatedCost;
  final Value<String?> closeResult;
  final Value<String?> rejectionReason;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> pendingSync;
  final Value<String?> syncError;
  final Value<int> localVersion;
  final Value<int> rowid;
  const MaintenanceOrdersCompanion({
    this.ownerUid = const Value.absent(),
    this.orderId = const Value.absent(),
    this.assetId = const Value.absent(),
    this.assetName = const Value.absent(),
    this.assetCode = const Value.absent(),
    this.description = const Value.absent(),
    this.requesterUid = const Value.absent(),
    this.requesterName = const Value.absent(),
    this.status = const Value.absent(),
    this.priority = const Value.absent(),
    this.technicianUid = const Value.absent(),
    this.technicianName = const Value.absent(),
    this.diagnosisCause = const Value.absent(),
    this.estimatedCost = const Value.absent(),
    this.closeResult = const Value.absent(),
    this.rejectionReason = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.pendingSync = const Value.absent(),
    this.syncError = const Value.absent(),
    this.localVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MaintenanceOrdersCompanion.insert({
    required String ownerUid,
    required String orderId,
    required String assetId,
    required String assetName,
    required String assetCode,
    required String description,
    required String requesterUid,
    required String requesterName,
    required String status,
    this.priority = const Value.absent(),
    this.technicianUid = const Value.absent(),
    this.technicianName = const Value.absent(),
    this.diagnosisCause = const Value.absent(),
    this.estimatedCost = const Value.absent(),
    this.closeResult = const Value.absent(),
    this.rejectionReason = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.pendingSync = const Value.absent(),
    this.syncError = const Value.absent(),
    this.localVersion = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : ownerUid = Value(ownerUid),
       orderId = Value(orderId),
       assetId = Value(assetId),
       assetName = Value(assetName),
       assetCode = Value(assetCode),
       description = Value(description),
       requesterUid = Value(requesterUid),
       requesterName = Value(requesterName),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<MaintenanceOrderRow> custom({
    Expression<String>? ownerUid,
    Expression<String>? orderId,
    Expression<String>? assetId,
    Expression<String>? assetName,
    Expression<String>? assetCode,
    Expression<String>? description,
    Expression<String>? requesterUid,
    Expression<String>? requesterName,
    Expression<String>? status,
    Expression<String>? priority,
    Expression<String>? technicianUid,
    Expression<String>? technicianName,
    Expression<String>? diagnosisCause,
    Expression<int>? estimatedCost,
    Expression<String>? closeResult,
    Expression<String>? rejectionReason,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? pendingSync,
    Expression<String>? syncError,
    Expression<int>? localVersion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (ownerUid != null) 'owner_uid': ownerUid,
      if (orderId != null) 'order_id': orderId,
      if (assetId != null) 'asset_id': assetId,
      if (assetName != null) 'asset_name': assetName,
      if (assetCode != null) 'asset_code': assetCode,
      if (description != null) 'description': description,
      if (requesterUid != null) 'requester_uid': requesterUid,
      if (requesterName != null) 'requester_name': requesterName,
      if (status != null) 'status': status,
      if (priority != null) 'priority': priority,
      if (technicianUid != null) 'technician_uid': technicianUid,
      if (technicianName != null) 'technician_name': technicianName,
      if (diagnosisCause != null) 'diagnosis_cause': diagnosisCause,
      if (estimatedCost != null) 'estimated_cost': estimatedCost,
      if (closeResult != null) 'close_result': closeResult,
      if (rejectionReason != null) 'rejection_reason': rejectionReason,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (pendingSync != null) 'pending_sync': pendingSync,
      if (syncError != null) 'sync_error': syncError,
      if (localVersion != null) 'local_version': localVersion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MaintenanceOrdersCompanion copyWith({
    Value<String>? ownerUid,
    Value<String>? orderId,
    Value<String>? assetId,
    Value<String>? assetName,
    Value<String>? assetCode,
    Value<String>? description,
    Value<String>? requesterUid,
    Value<String>? requesterName,
    Value<String>? status,
    Value<String?>? priority,
    Value<String?>? technicianUid,
    Value<String?>? technicianName,
    Value<String?>? diagnosisCause,
    Value<int?>? estimatedCost,
    Value<String?>? closeResult,
    Value<String?>? rejectionReason,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? pendingSync,
    Value<String?>? syncError,
    Value<int>? localVersion,
    Value<int>? rowid,
  }) {
    return MaintenanceOrdersCompanion(
      ownerUid: ownerUid ?? this.ownerUid,
      orderId: orderId ?? this.orderId,
      assetId: assetId ?? this.assetId,
      assetName: assetName ?? this.assetName,
      assetCode: assetCode ?? this.assetCode,
      description: description ?? this.description,
      requesterUid: requesterUid ?? this.requesterUid,
      requesterName: requesterName ?? this.requesterName,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      technicianUid: technicianUid ?? this.technicianUid,
      technicianName: technicianName ?? this.technicianName,
      diagnosisCause: diagnosisCause ?? this.diagnosisCause,
      estimatedCost: estimatedCost ?? this.estimatedCost,
      closeResult: closeResult ?? this.closeResult,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      pendingSync: pendingSync ?? this.pendingSync,
      syncError: syncError ?? this.syncError,
      localVersion: localVersion ?? this.localVersion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (ownerUid.present) {
      map['owner_uid'] = Variable<String>(ownerUid.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (assetId.present) {
      map['asset_id'] = Variable<String>(assetId.value);
    }
    if (assetName.present) {
      map['asset_name'] = Variable<String>(assetName.value);
    }
    if (assetCode.present) {
      map['asset_code'] = Variable<String>(assetCode.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (requesterUid.present) {
      map['requester_uid'] = Variable<String>(requesterUid.value);
    }
    if (requesterName.present) {
      map['requester_name'] = Variable<String>(requesterName.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (technicianUid.present) {
      map['technician_uid'] = Variable<String>(technicianUid.value);
    }
    if (technicianName.present) {
      map['technician_name'] = Variable<String>(technicianName.value);
    }
    if (diagnosisCause.present) {
      map['diagnosis_cause'] = Variable<String>(diagnosisCause.value);
    }
    if (estimatedCost.present) {
      map['estimated_cost'] = Variable<int>(estimatedCost.value);
    }
    if (closeResult.present) {
      map['close_result'] = Variable<String>(closeResult.value);
    }
    if (rejectionReason.present) {
      map['rejection_reason'] = Variable<String>(rejectionReason.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (pendingSync.present) {
      map['pending_sync'] = Variable<bool>(pendingSync.value);
    }
    if (syncError.present) {
      map['sync_error'] = Variable<String>(syncError.value);
    }
    if (localVersion.present) {
      map['local_version'] = Variable<int>(localVersion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceOrdersCompanion(')
          ..write('ownerUid: $ownerUid, ')
          ..write('orderId: $orderId, ')
          ..write('assetId: $assetId, ')
          ..write('assetName: $assetName, ')
          ..write('assetCode: $assetCode, ')
          ..write('description: $description, ')
          ..write('requesterUid: $requesterUid, ')
          ..write('requesterName: $requesterName, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('technicianUid: $technicianUid, ')
          ..write('technicianName: $technicianName, ')
          ..write('diagnosisCause: $diagnosisCause, ')
          ..write('estimatedCost: $estimatedCost, ')
          ..write('closeResult: $closeResult, ')
          ..write('rejectionReason: $rejectionReason, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('pendingSync: $pendingSync, ')
          ..write('syncError: $syncError, ')
          ..write('localVersion: $localVersion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MaintenanceOrdersTable maintenanceOrders =
      $MaintenanceOrdersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [maintenanceOrders];
}

typedef $$MaintenanceOrdersTableCreateCompanionBuilder =
    MaintenanceOrdersCompanion Function({
      required String ownerUid,
      required String orderId,
      required String assetId,
      required String assetName,
      required String assetCode,
      required String description,
      required String requesterUid,
      required String requesterName,
      required String status,
      Value<String?> priority,
      Value<String?> technicianUid,
      Value<String?> technicianName,
      Value<String?> diagnosisCause,
      Value<int?> estimatedCost,
      Value<String?> closeResult,
      Value<String?> rejectionReason,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<bool> pendingSync,
      Value<String?> syncError,
      Value<int> localVersion,
      Value<int> rowid,
    });
typedef $$MaintenanceOrdersTableUpdateCompanionBuilder =
    MaintenanceOrdersCompanion Function({
      Value<String> ownerUid,
      Value<String> orderId,
      Value<String> assetId,
      Value<String> assetName,
      Value<String> assetCode,
      Value<String> description,
      Value<String> requesterUid,
      Value<String> requesterName,
      Value<String> status,
      Value<String?> priority,
      Value<String?> technicianUid,
      Value<String?> technicianName,
      Value<String?> diagnosisCause,
      Value<int?> estimatedCost,
      Value<String?> closeResult,
      Value<String?> rejectionReason,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> pendingSync,
      Value<String?> syncError,
      Value<int> localVersion,
      Value<int> rowid,
    });

class $$MaintenanceOrdersTableFilterComposer
    extends Composer<_$AppDatabase, $MaintenanceOrdersTable> {
  $$MaintenanceOrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get ownerUid => $composableBuilder(
    column: $table.ownerUid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assetId => $composableBuilder(
    column: $table.assetId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assetName => $composableBuilder(
    column: $table.assetName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assetCode => $composableBuilder(
    column: $table.assetCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get requesterUid => $composableBuilder(
    column: $table.requesterUid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get requesterName => $composableBuilder(
    column: $table.requesterName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get technicianUid => $composableBuilder(
    column: $table.technicianUid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get technicianName => $composableBuilder(
    column: $table.technicianName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get diagnosisCause => $composableBuilder(
    column: $table.diagnosisCause,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get estimatedCost => $composableBuilder(
    column: $table.estimatedCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get closeResult => $composableBuilder(
    column: $table.closeResult,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rejectionReason => $composableBuilder(
    column: $table.rejectionReason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncError => $composableBuilder(
    column: $table.syncError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get localVersion => $composableBuilder(
    column: $table.localVersion,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MaintenanceOrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $MaintenanceOrdersTable> {
  $$MaintenanceOrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get ownerUid => $composableBuilder(
    column: $table.ownerUid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get orderId => $composableBuilder(
    column: $table.orderId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assetId => $composableBuilder(
    column: $table.assetId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assetName => $composableBuilder(
    column: $table.assetName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assetCode => $composableBuilder(
    column: $table.assetCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get requesterUid => $composableBuilder(
    column: $table.requesterUid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get requesterName => $composableBuilder(
    column: $table.requesterName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get technicianUid => $composableBuilder(
    column: $table.technicianUid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get technicianName => $composableBuilder(
    column: $table.technicianName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get diagnosisCause => $composableBuilder(
    column: $table.diagnosisCause,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get estimatedCost => $composableBuilder(
    column: $table.estimatedCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get closeResult => $composableBuilder(
    column: $table.closeResult,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rejectionReason => $composableBuilder(
    column: $table.rejectionReason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncError => $composableBuilder(
    column: $table.syncError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get localVersion => $composableBuilder(
    column: $table.localVersion,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MaintenanceOrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $MaintenanceOrdersTable> {
  $$MaintenanceOrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get ownerUid =>
      $composableBuilder(column: $table.ownerUid, builder: (column) => column);

  GeneratedColumn<String> get orderId =>
      $composableBuilder(column: $table.orderId, builder: (column) => column);

  GeneratedColumn<String> get assetId =>
      $composableBuilder(column: $table.assetId, builder: (column) => column);

  GeneratedColumn<String> get assetName =>
      $composableBuilder(column: $table.assetName, builder: (column) => column);

  GeneratedColumn<String> get assetCode =>
      $composableBuilder(column: $table.assetCode, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get requesterUid => $composableBuilder(
    column: $table.requesterUid,
    builder: (column) => column,
  );

  GeneratedColumn<String> get requesterName => $composableBuilder(
    column: $table.requesterName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get technicianUid => $composableBuilder(
    column: $table.technicianUid,
    builder: (column) => column,
  );

  GeneratedColumn<String> get technicianName => $composableBuilder(
    column: $table.technicianName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get diagnosisCause => $composableBuilder(
    column: $table.diagnosisCause,
    builder: (column) => column,
  );

  GeneratedColumn<int> get estimatedCost => $composableBuilder(
    column: $table.estimatedCost,
    builder: (column) => column,
  );

  GeneratedColumn<String> get closeResult => $composableBuilder(
    column: $table.closeResult,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rejectionReason => $composableBuilder(
    column: $table.rejectionReason,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => column,
  );

  GeneratedColumn<String> get syncError =>
      $composableBuilder(column: $table.syncError, builder: (column) => column);

  GeneratedColumn<int> get localVersion => $composableBuilder(
    column: $table.localVersion,
    builder: (column) => column,
  );
}

class $$MaintenanceOrdersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MaintenanceOrdersTable,
          MaintenanceOrderRow,
          $$MaintenanceOrdersTableFilterComposer,
          $$MaintenanceOrdersTableOrderingComposer,
          $$MaintenanceOrdersTableAnnotationComposer,
          $$MaintenanceOrdersTableCreateCompanionBuilder,
          $$MaintenanceOrdersTableUpdateCompanionBuilder,
          (
            MaintenanceOrderRow,
            BaseReferences<
              _$AppDatabase,
              $MaintenanceOrdersTable,
              MaintenanceOrderRow
            >,
          ),
          MaintenanceOrderRow,
          PrefetchHooks Function()
        > {
  $$MaintenanceOrdersTableTableManager(
    _$AppDatabase db,
    $MaintenanceOrdersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MaintenanceOrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MaintenanceOrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MaintenanceOrdersTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> ownerUid = const Value.absent(),
                Value<String> orderId = const Value.absent(),
                Value<String> assetId = const Value.absent(),
                Value<String> assetName = const Value.absent(),
                Value<String> assetCode = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> requesterUid = const Value.absent(),
                Value<String> requesterName = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> priority = const Value.absent(),
                Value<String?> technicianUid = const Value.absent(),
                Value<String?> technicianName = const Value.absent(),
                Value<String?> diagnosisCause = const Value.absent(),
                Value<int?> estimatedCost = const Value.absent(),
                Value<String?> closeResult = const Value.absent(),
                Value<String?> rejectionReason = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> pendingSync = const Value.absent(),
                Value<String?> syncError = const Value.absent(),
                Value<int> localVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MaintenanceOrdersCompanion(
                ownerUid: ownerUid,
                orderId: orderId,
                assetId: assetId,
                assetName: assetName,
                assetCode: assetCode,
                description: description,
                requesterUid: requesterUid,
                requesterName: requesterName,
                status: status,
                priority: priority,
                technicianUid: technicianUid,
                technicianName: technicianName,
                diagnosisCause: diagnosisCause,
                estimatedCost: estimatedCost,
                closeResult: closeResult,
                rejectionReason: rejectionReason,
                createdAt: createdAt,
                updatedAt: updatedAt,
                pendingSync: pendingSync,
                syncError: syncError,
                localVersion: localVersion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String ownerUid,
                required String orderId,
                required String assetId,
                required String assetName,
                required String assetCode,
                required String description,
                required String requesterUid,
                required String requesterName,
                required String status,
                Value<String?> priority = const Value.absent(),
                Value<String?> technicianUid = const Value.absent(),
                Value<String?> technicianName = const Value.absent(),
                Value<String?> diagnosisCause = const Value.absent(),
                Value<int?> estimatedCost = const Value.absent(),
                Value<String?> closeResult = const Value.absent(),
                Value<String?> rejectionReason = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<bool> pendingSync = const Value.absent(),
                Value<String?> syncError = const Value.absent(),
                Value<int> localVersion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MaintenanceOrdersCompanion.insert(
                ownerUid: ownerUid,
                orderId: orderId,
                assetId: assetId,
                assetName: assetName,
                assetCode: assetCode,
                description: description,
                requesterUid: requesterUid,
                requesterName: requesterName,
                status: status,
                priority: priority,
                technicianUid: technicianUid,
                technicianName: technicianName,
                diagnosisCause: diagnosisCause,
                estimatedCost: estimatedCost,
                closeResult: closeResult,
                rejectionReason: rejectionReason,
                createdAt: createdAt,
                updatedAt: updatedAt,
                pendingSync: pendingSync,
                syncError: syncError,
                localVersion: localVersion,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MaintenanceOrdersTable, MaintenanceOrderRow>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $MaintenanceOrdersTable,
                    MaintenanceOrderRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MaintenanceOrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MaintenanceOrdersTable,
      MaintenanceOrderRow,
      $$MaintenanceOrdersTableFilterComposer,
      $$MaintenanceOrdersTableOrderingComposer,
      $$MaintenanceOrdersTableAnnotationComposer,
      $$MaintenanceOrdersTableCreateCompanionBuilder,
      $$MaintenanceOrdersTableUpdateCompanionBuilder,
      (
        MaintenanceOrderRow,
        BaseReferences<
          _$AppDatabase,
          $MaintenanceOrdersTable,
          MaintenanceOrderRow
        >,
      ),
      MaintenanceOrderRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MaintenanceOrdersTableTableManager get maintenanceOrders =>
      $$MaintenanceOrdersTableTableManager(_db, _db.maintenanceOrders);
}
