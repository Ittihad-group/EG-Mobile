import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../../locale/presentation/cubit/locale_cubit.dart';
import '../../../locale/presentation/cubit/locale_state.dart';
import '../cubit/production_cubit.dart';
import '../cubit/production_state.dart';

class ProductionPage extends StatelessWidget {
  const ProductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductionCubit>()..load(),
      child: const _ProductionView(),
    );
  }
}

class _ProductionView extends StatelessWidget {
  const _ProductionView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, locale) {
        final isArabic = locale.isArabic;
        String t(String ar, String en) => Formatters.t(ar, en, isArabic: isArabic);
        String status(String c) => Formatters.statusLabel(c, isArabic: isArabic);

        return BlocBuilder<ProductionCubit, ProductionState>(
          builder: (context, state) {
            if (state is ProductionLoading || state is ProductionInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ProductionError) {
              return Center(child: Text(state.message));
            }
            final orders = (state as ProductionLoaded).orders;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (_, i) {
                final w = orders[i];
                return Card(
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
                                style: const TextStyle(fontWeight: FontWeight.w800),
                              ),
                            ),
                            StatusChip(label: status(w.status), status: w.status),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(t(w.productAr, w.productEn)),
                        Text('${t(w.lineAr, w.lineEn)} · ${t('كمية', 'Qty')}: ${w.qty}'),
                        Text(
                          '${t('الاستحقاق', 'Due')}: ${w.dueDate}',
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                        ),
                        const SizedBox(height: 10),
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
                );
              },
            );
          },
        );
      },
    );
  }
}
