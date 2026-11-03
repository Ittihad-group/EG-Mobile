import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/utils/formatters.dart';
import '../../../locale/presentation/cubit/locale_cubit.dart';
import '../../../locale/presentation/cubit/locale_state.dart';
import '../cubit/customers_cubit.dart';
import '../cubit/customers_state.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CustomersCubit>()..load(),
      child: const _CustomersView(),
    );
  }
}

class _CustomersView extends StatelessWidget {
  const _CustomersView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, locale) {
        final isArabic = locale.isArabic;
        String t(String ar, String en) => Formatters.t(ar, en, isArabic: isArabic);
        String money(num v) => Formatters.money(v, isArabic: isArabic);
        String status(String c) => Formatters.statusLabel(c, isArabic: isArabic);

        return BlocBuilder<CustomersCubit, CustomersState>(
          builder: (context, state) {
            if (state is CustomersLoading || state is CustomersInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CustomersError) {
              return Center(child: Text(state.message));
            }
            final customers = (state as CustomersLoaded).customers;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: customers.length,
              itemBuilder: (_, i) {
                final c = customers[i];
                return Card(
                  child: ListTile(
                    title: Text(
                      t(c.nameAr, c.nameEn),
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      '${c.code} · ${status(c.type)} · ${t(c.cityAr, c.cityEn)}\n${c.phone}',
                    ),
                    isThreeLine: true,
                    trailing: Text(
                      money(c.balance),
                      style: const TextStyle(fontWeight: FontWeight.w800),
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
