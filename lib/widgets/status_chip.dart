import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class StatusChip extends StatelessWidget {
  final String label;
  final String status;

  const StatusChip({super.key, required this.label, required this.status});

  Color get _bg {
    switch (status) {
      case 'shipped':
      case 'done':
        return const Color(0xFFE7F6EE);
      case 'production':
      case 'in_progress':
      case 'queued':
        return const Color(0xFFFFF3E0);
      case 'confirmed':
        return const Color(0xFFE5F2FF);
      default:
        return const Color(0xFFECEFF1);
    }
  }

  Color get _fg {
    switch (status) {
      case 'shipped':
      case 'done':
        return AppTheme.forest;
      case 'production':
      case 'in_progress':
      case 'queued':
        return AppTheme.brass;
      case 'confirmed':
        return const Color(0xFF1D5C7A);
      default:
        return const Color(0xFF455A64);
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
