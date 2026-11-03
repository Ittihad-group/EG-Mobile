import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({super.key, required this.label, required this.status});

  final String label;
  final String status;

  Color get _bg {
    switch (status) {
      case 'shipped':
      case 'done':
        return AppColors.successBg;
      case 'production':
      case 'in_progress':
      case 'queued':
        return AppColors.warningBg;
      case 'confirmed':
        return AppColors.infoBg;
      default:
        return AppColors.neutralBg;
    }
  }

  Color get _fg {
    switch (status) {
      case 'shipped':
      case 'done':
        return AppColors.forest;
      case 'production':
      case 'in_progress':
      case 'queued':
        return AppColors.brass;
      case 'confirmed':
        return AppColors.infoFg;
      default:
        return AppColors.neutralFg;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(color: _fg, fontWeight: FontWeight.w700, fontSize: 12),
      ),
    );
  }
}
