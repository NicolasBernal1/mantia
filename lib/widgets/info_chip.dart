import 'package:flutter/material.dart';

class InfoChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? backgroundColor;

  const InfoChip({
    super.key,
    required this.label,
    required this.icon,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(label),
      side: BorderSide.none,
      backgroundColor: backgroundColor ?? colors.secondaryContainer,
    );
  }
}
