import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/utils/formatters.dart';
import '../../../locale/presentation/cubit/locale_cubit.dart';
import '../../../locale/presentation/cubit/locale_state.dart';
import '../cubit/products_cubit.dart';
import '../cubit/products_state.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProductsCubit>()..load(),
      child: const _ProductsView(),
    );
  }
}

class _ProductsView extends StatelessWidget {
  const _ProductsView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, locale) {
        final isArabic = locale.isArabic;
        String t(String ar, String en) => Formatters.t(ar, en, isArabic: isArabic);
        String money(num v) => Formatters.money(v, isArabic: isArabic);

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: t('بحث…', 'Search…'),
                ),
                onChanged: (v) => context.read<ProductsCubit>().search(v),
              ),
            ),
            Expanded(
              child: BlocBuilder<ProductsCubit, ProductsState>(
                builder: (context, state) {
                  if (state is ProductsLoading || state is ProductsInitial) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is ProductsError) {
                    return Center(child: Text(state.message));
                  }
                  final products = (state as ProductsLoaded).products;
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: products.length,
                    itemBuilder: (_, i) {
                      final p = products[i];
                      return Card(
                        child: ListTile(
                          title: Text(
                            t(p.nameAr, p.nameEn),
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          subtitle: Text(
                            '${p.sku} · ${t(p.categoryAr, p.categoryEn)}',
                          ),
                          trailing: Text(
                            money(p.price),
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                          isThreeLine: true,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              showDragHandle: true,
                              builder: (_) => Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      t(p.nameAr, p.nameEn),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text('${t('الكود', 'SKU')}: ${p.sku}'),
                                    Text('${t('السعر', 'Price')}: ${money(p.price)}'),
                                    Text('${t('التكلفة', 'Cost')}: ${money(p.cost)}'),
                                    if (p.widthsCm.isNotEmpty)
                                      Text(
                                        '${t('العروض', 'Widths')}: ${p.widthsCm.join(' / ')} سم',
                                      ),
                                    if (p.colors.isNotEmpty)
                                      Text(
                                        '${t('الألوان', 'Colors')}: ${p.colors.join(', ')}',
                                      ),
                                    const SizedBox(height: 12),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
