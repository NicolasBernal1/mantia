import 'package:mantia/core/order_rules.dart';
import 'package:mantia/models/order_status.dart';

class MaintenanceOrder {
  final String id;
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

  const MaintenanceOrder({
    required this.id,
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
    this.pendingSync = false,
    this.syncError,
    this.localVersion = 1,
  });

  bool get isFinished =>
      status == OrderStatus.closed || status == OrderStatus.rejected || status == OrderStatus.finished;

  bool get isOverBudget =>
      estimatedCost != null && estimatedCost! > OrderRules.repairBudget;

  bool get hasCompleteDiagnosis =>
      (diagnosisCause ?? '').trim().isNotEmpty && estimatedCost != null;

  factory MaintenanceOrder.fromJson(Map<String, dynamic> json) {
    return MaintenanceOrder(
      id: json['id'] as String,
      assetId: json['asset_id'] as String,
      assetName: json['asset_name'] as String,
      assetCode: json['asset_code'] as String,
      description: json['description'] as String,
      requesterUid: json['requester_uid'] as String,
      requesterName: json['requester_name'] as String,
      status: json['status'] as String,
      priority: json['priority'] as String?,
      technicianUid: json['technician_uid'] as String?,
      technicianName: json['technician_name'] as String?,
      diagnosisCause: json['diagnosis_cause'] as String?,
      estimatedCost: (json['estimated_cost'] as num?)?.toInt(),
      closeResult: json['close_result'] as String?,
      rejectionReason: json['rejection_reason'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'asset_id': assetId,
    'asset_name': assetName,
    'asset_code': assetCode,
    'description': description,
    'requester_uid': requesterUid,
    'requester_name': requesterName,
    'status': status,
    'priority': priority,
    'technician_uid': technicianUid,
    'technician_name': technicianName,
    'diagnosis_cause': diagnosisCause,
    'estimated_cost': estimatedCost,
    'close_result': closeResult,
    'rejection_reason': rejectionReason,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}
