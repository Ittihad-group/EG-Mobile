import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/utils/formatters.dart';
import '../../../../core/widgets/status_chip.dart';
import '../../../locale/presentation/cubit/locale_cubit.dart';
import '../../../locale/presentation/cubit/locale_state.dart';
import '../cubit/sales_cubit.dart';
import '../cubit/sales_state.dart';

class SalesPage extends StatelessWidget {
  const SalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SalesCubit>()..load(),
      child: const _SalesView(),
    );
  }
}

class _SalesView extends StatelessWidget {
  const _SalesView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, locale) {
        final isArabic = locale.isArabic;
        String t(String ar, String en) => Formatters.t(ar, en, isArabic: isArabic);
        String money(num v) => Formatters.money(v, isArabic: isArabic);
        String status(String c) => Formatters.statusLabel(c, isArabic: isArabic);

        return BlocBuilder<SalesCubit, SalesState>(
          builder: (context, state) {
            if (state is SalesLoading || state is SalesInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is SalesError) {
              return Center(child: Text(state.message));
            }
            final orders = (state as SalesLoaded).orders;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (_, i) {
                final o = orders[i];
                return Card(
                  child: ListTile(
                    title: Text(o.number, style: const TextStyle(fontWeight: FontWeight.w800)),
                    subtitle: Text('${t(o.customerAr, o.customerEn)}\n${o.date}'),
                    isThreeLine: true,
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        StatusChip(label: status(o.status), status: o.status),
                        const SizedBox(height: 6),
                        Text(money(o.total), style: const TextStyle(fontWeight: FontWeight.w800)),
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
