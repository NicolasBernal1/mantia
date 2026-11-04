import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mantia/models/maintenance_order.dart';
import 'package:mantia/models/order_status.dart';
import 'package:mantia/widgets/info_chip.dart';

class OrderCard extends StatelessWidget {
  final MaintenanceOrder order;
  final VoidCallback onTap;

  const OrderCard({super.key, required this.order, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${order.assetName} · ${order.assetCode}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                order.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  InfoChip(
                    icon: Icons.flag_outlined,
                    label: OrderStatus.label(order.status),
                  ),
                  if (order.pendingSync)
                    InfoChip(
                      icon: order.syncError == null
                          ? Icons.cloud_upload_outlined
                          : Icons.error_outline,
                      label: order.syncError == null
                          ? 'Pendiente de sincronizar'
                          : 'Error al sincronizar',
                      backgroundColor: order.syncError == null
                          ? colors.tertiaryContainer
                          : colors.errorContainer,
                    ),
                  if (order.priority != null)
                    InfoChip(
                      icon: Icons.priority_high,
                      label:
                          'Prioridad ${OrderPriority.label(order.priority!)}',
                      backgroundColor: colors.surfaceContainerHighest,
                    ),
                ],
              ),
              if (order.technicianName != null) ...[
                const SizedBox(height: 4),
                Text(
                  'Técnico: ${order.technicianName}',
                  style: TextStyle(color: colors.onSurfaceVariant),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
