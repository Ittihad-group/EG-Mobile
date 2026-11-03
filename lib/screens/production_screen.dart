import 'package:flutter/material.dart';
import '../data/seed.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/status_chip.dart';

class ProductionScreen extends StatelessWidget {
  final AppState state;
  const ProductionScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final s = state;
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: workOrders.length,
      itemBuilder: (_, i) {
        final w = workOrders[i];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(w.number, style: const TextStyle(fontWeight: FontWeight.w800))),
                    StatusChip(label: s.statusLabel(w.status), status: w.status),
                  ],
                ),
                const SizedBox(height: 6),
                Text(s.t(w.productAr, w.productEn)),
                Text('${s.t(w.lineAr, w.lineEn)} · ${s.t('كمية', 'Qty')}: ${w.qty}'),
                Text('${s.t('الاستحقاق', 'Due')}: ${w.dueDate}', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                const SizedBox(height: 10),
                LinearProgressIndicator(
                  value: w.progress / 100,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(8),
                  color: AppTheme.brass,
                  backgroundColor: Colors.grey.shade200,
                ),
                const SizedBox(height: 4),
                Text('${w.progress}%'),
              ],
            ),
          ),
        );
      },
    );
  }
}
