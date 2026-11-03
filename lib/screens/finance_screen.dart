import 'package:flutter/material.dart';
import '../data/seed.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../widgets/stat_card.dart';

class FinanceScreen extends StatelessWidget {
  final AppState state;
  const FinanceScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final s = state;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.4,
          children: [
            StatCard(label: s.t('مبيعات الشهر', 'Month sales'), value: s.money(finance.monthSales), accent: AppTheme.brass),
            StatCard(label: s.t('ذمم مدينة', 'Receivables'), value: s.money(finance.receivables)),
            StatCard(label: s.t('ذمم دائنة', 'Payables'), value: s.money(finance.payables), accent: AppTheme.brass),
            StatCard(label: s.t('نقدية', 'Cash'), value: s.money(finance.cash), accent: AppTheme.forest),
          ],
        ),
        const SizedBox(height: 16),
        Text(s.t('أرصدة العملاء', 'Customer balances'), style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
        const SizedBox(height: 8),
        ...customers.where((c) => c.balance > 0).map(
          (c) => Card(
            child: ListTile(
              title: Text(s.t(c.nameAr, c.nameEn)),
              subtitle: Text(c.code),
              trailing: Text(s.money(c.balance), style: const TextStyle(fontWeight: FontWeight.w800)),
            ),
          ),
        ),
      ],
    );
  }
}
