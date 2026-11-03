import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/stat_card.dart';
import '../../../locale/presentation/cubit/locale_cubit.dart';
import '../../../locale/presentation/cubit/locale_state.dart';
import '../cubit/finance_cubit.dart';
import '../cubit/finance_state.dart';

class FinancePage extends StatelessWidget {
  const FinancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<FinanceCubit>()..load(),
      child: const _FinanceView(),
    );
  }
}

class _FinanceView extends StatelessWidget {
  const _FinanceView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, locale) {
        final isArabic = locale.isArabic;
        String t(String ar, String en) => Formatters.t(ar, en, isArabic: isArabic);
        String money(num v) => Formatters.money(v, isArabic: isArabic);

        return BlocBuilder<FinanceCubit, FinanceState>(
          builder: (context, state) {
            if (state is FinanceLoading || state is FinanceInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is FinanceError) {
              return Center(child: Text(state.message));
            }
            final f = (state as FinanceLoaded).summary;
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
                    StatCard(
                      label: t('مبيعات الشهر', 'Month sales'),
                      value: money(f.monthSales),
                      accent: AppColors.brass,
                    ),
                    StatCard(
                      label: t('ذمم مدينة', 'Receivables'),
                      value: money(f.receivables),
                    ),
                    StatCard(
                      label: t('ذمم دائنة', 'Payables'),
                      value: money(f.payables),
                      accent: AppColors.brass,
                    ),
                    StatCard(
                      label: t('نقدية', 'Cash'),
                      value: money(f.cash),
                      accent: AppColors.forest,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  t('أرصدة العملاء', 'Customer balances'),
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                ),
                const SizedBox(height: 8),
                ...f.customerBalances.map(
                  (c) => Card(
                    child: ListTile(
                      title: Text(t(c.nameAr, c.nameEn)),
                      subtitle: Text(c.code),
                      trailing: Text(
                        money(c.balance),
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
