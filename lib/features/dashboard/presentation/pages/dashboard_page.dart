import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/company_info.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/stat_card.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../../locale/presentation/cubit/locale_cubit.dart';
import '../../../locale/presentation/cubit/locale_state.dart';
import '../cubit/dashboard_cubit.dart';
import '../cubit/dashboard_state.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DashboardCubit>()..load(),
      child: const _DashboardView(),
    );
  }
}

class _DashboardView extends StatelessWidget {
  const _DashboardView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, locale) {
        final isArabic = locale.isArabic;
        String t(String ar, String en) => Formatters.t(ar, en, isArabic: isArabic);
        String money(num v) => Formatters.money(v, isArabic: isArabic);
        String status(String c) => Formatters.statusLabel(c, isArabic: isArabic);

        return BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            if (state is DashboardLoading || state is DashboardInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is DashboardError) {
              return Center(child: Text(state.message));
            }
            final d = (state as DashboardLoaded).data;
            final low = d.lowStockCount;

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  t(CompanyInfo.plantAr, CompanyInfo.plantEn),
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
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
                    StatCard(
                      label: t('مبيعات الشهر', 'Month sales'),
                      value: money(d.monthSales),
                      accent: AppColors.brass,
                    ),
                    StatCard(
                      label: t('أوامر مفتوحة', 'Open orders'),
                      value: '${d.openSalesCount}',
                    ),
                    StatCard(
                      label: t('تحت التشغيل', 'In production'),
                      value: '${d.wipCount}',
                      accent: AppColors.brass,
                    ),
                    StatCard(
                      label: t('مخزون منخفض', 'Low stock'),
                      value: '$low',
                      accent: low > 0 ? Colors.red : AppColors.forest,
                    ),
                    StatCard(
                      label: t('ذمم مدينة', 'Receivables'),
                      value: money(d.receivables),
                    ),
                    StatCard(
                      label: t('نقدية', 'Cash'),
                      value: money(d.cash),
                      accent: AppColors.forest,
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Text(
                  t('أحدث أوامر البيع', 'Latest sales orders'),
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                ),
                const SizedBox(height: 8),
                ...d.latestSales.map(
                  (o) => Card(
                    child: ListTile(
                      title: Text(
                        o.number,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(t(o.customerAr, o.customerEn)),
                      trailing: StatusChip(
                        label: status(o.status),
                        status: o.status,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  t('أوامر التشغيل', 'Work orders'),
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                ),
                const SizedBox(height: 8),
                ...d.workOrders.map(
                  (w) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  w.number,
                                  style: const TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ),
                              StatusChip(
                                label: status(w.status),
                                status: w.status,
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(t(w.productAr, w.productEn)),
                          Text(
                            t(w.lineAr, w.lineEn),
                            style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                          ),
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: w.progress / 100,
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.brass,
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
          },
        );
      },
    );
  }
}
