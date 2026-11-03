import 'package:flutter/material.dart';
import '../data/seed.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/stat_card.dart';
import '../widgets/status_chip.dart';

class DashboardScreen extends StatelessWidget {
  final AppState state;
  const DashboardScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final s = state;
    final openSales = salesOrders.where((o) => o.status != 'shipped' && o.status != 'draft').length;
    final wip = workOrders.where((w) => w.status == 'in_progress' || w.status == 'queued').length;
    final low = inventory.where((row) {
      final p = productById(row.productId);
      return p != null && row.available < p.minStock;
    }).length;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          s.t(CompanyInfo.plantAr, CompanyInfo.plantEn),
          style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.45,
          children: [
            StatCard(label: s.t('مبيعات الشهر', 'Month sales'), value: s.money(finance.monthSales), accent: AppTheme.brass),
            StatCard(label: s.t('أوامر مفتوحة', 'Open orders'), value: '$openSales'),
            StatCard(label: s.t('تحت التشغيل', 'In production'), value: '$wip', accent: AppTheme.brass),
            StatCard(label: s.t('مخزون منخفض', 'Low stock'), value: '$low', accent: low > 0 ? Colors.red : AppTheme.forest),
            StatCard(label: s.t('ذمم مدينة', 'Receivables'), value: s.money(finance.receivables)),
            StatCard(label: s.t('نقدية', 'Cash'), value: s.money(finance.cash), accent: AppTheme.forest),
          ],
        ),
        const SizedBox(height: 18),
        Text(s.t('أحدث أوامر البيع', 'Latest sales orders'), style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
        const SizedBox(height: 8),
        ...salesOrders.take(3).map(
          (o) => Card(
            child: ListTile(
              title: Text(o.number, style: const TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text(s.t(o.customerAr, o.customerEn)),
              trailing: StatusChip(label: s.statusLabel(o.status), status: o.status),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(s.t('أوامر التشغيل', 'Work orders'), style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
        const SizedBox(height: 8),
        ...workOrders.map(
          (w) => Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(w.number, style: const TextStyle(fontWeight: FontWeight.w700))),
                      StatusChip(label: s.statusLabel(w.status), status: w.status),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(s.t(w.productAr, w.productEn)),
                  Text(s.t(w.lineAr, w.lineEn), style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                  const SizedBox(height: 8),
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
          ),
        ),
      ],
    );
  }
}
