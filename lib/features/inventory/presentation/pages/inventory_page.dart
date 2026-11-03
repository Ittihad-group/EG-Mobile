import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/utils/formatters.dart';
import '../../../locale/presentation/cubit/locale_cubit.dart';
import '../../../locale/presentation/cubit/locale_state.dart';
import '../cubit/inventory_cubit.dart';
import '../cubit/inventory_state.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<InventoryCubit>()..load(),
      child: const _InventoryView(),
    );
  }
}

class _InventoryView extends StatelessWidget {
  const _InventoryView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, locale) {
        final isArabic = locale.isArabic;
        String t(String ar, String en) => Formatters.t(ar, en, isArabic: isArabic);

        return BlocBuilder<InventoryCubit, InventoryState>(
          builder: (context, state) {
            if (state is InventoryLoading || state is InventoryInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is InventoryError) {
              return Center(child: Text(state.message));
            }
            final items = (state as InventoryLoaded).items;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (_, i) {
                final row = items[i];
                final p = row.product;
                final low = row.isLowStock;
                return Card(
                  child: ListTile(
                    title: Text(
                      p == null ? row.productId : t(p.nameAr, p.nameEn),
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      '${p?.sku ?? ''} · ${t(row.warehouseAr, row.warehouseEn)}\n'
                      '${t('رصيد', 'Stock')}: ${row.qty} · ${t('محجوز', 'Reserved')}: ${row.reserved}',
                    ),
                    isThreeLine: true,
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${row.available}',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            color: low ? Colors.red : null,
                          ),
                        ),
                        Text(
                          t('متاح', 'Avail'),
                          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                        ),
                        if (low)
                          Text(
                            t('منخفض', 'Low'),
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
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
