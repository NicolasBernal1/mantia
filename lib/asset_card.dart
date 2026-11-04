import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mantia/models/office_asset.dart';
import 'package:mantia/widgets/info_chip.dart';

class AssetCard extends StatelessWidget {
  final OfficeAsset asset;
  final bool? isOccupied;
  final VoidCallback onTap;

  const AssetCard({
    super.key,
    required this.asset,
    required this.isOccupied,
    required this.onTap,
  });

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
                asset.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${asset.internalCode} · ${asset.type}\n${asset.location}',
                style: TextStyle(color: colors.onSurfaceVariant),
              ),
              if (isOccupied != null) ...[
                const SizedBox(height: 8),
                InfoChip(
                  icon: isOccupied!
                      ? Icons.build_outlined
                      : Icons.check_circle_outline,
                  label: isOccupied! ? 'Ocupado (orden activa)' : 'Disponible',
                  backgroundColor: isOccupied!
                      ? colors.tertiaryContainer
                      : colors.secondaryContainer,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
