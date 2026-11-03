import 'package:flutter/material.dart';
import '../data/seed.dart';
import '../state/app_state.dart';

class ProductsScreen extends StatefulWidget {
  final AppState state;
  const ProductsScreen({super.key, required this.state});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String q = '';

  @override
  Widget build(BuildContext context) {
    final s = widget.state;
    final filtered = products.where((p) {
      final term = q.trim().toLowerCase();
      if (term.isEmpty) return true;
      return p.sku.toLowerCase().contains(term) ||
          p.nameAr.contains(q) ||
          p.nameEn.toLowerCase().contains(term);
    }).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: s.t('بحث…', 'Search…'),
            ),
            onChanged: (v) => setState(() => q = v),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filtered.length,
            itemBuilder: (_, i) {
              final p = filtered[i];
              return Card(
                child: ListTile(
                  title: Text(s.t(p.nameAr, p.nameEn), style: const TextStyle(fontWeight: FontWeight.w700)),
                  subtitle: Text('${p.sku} · ${s.t(p.categoryAr, p.categoryEn)}'),
                  trailing: Text(s.money(p.price), style: const TextStyle(fontWeight: FontWeight.w800)),
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
                            Text(s.t(p.nameAr, p.nameEn), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                            const SizedBox(height: 8),
                            Text('${s.t('الكود', 'SKU')}: ${p.sku}'),
                            Text('${s.t('السعر', 'Price')}: ${s.money(p.price)}'),
                            Text('${s.t('التكلفة', 'Cost')}: ${s.money(p.cost)}'),
                            if (p.widthsCm.isNotEmpty)
                              Text('${s.t('العروض', 'Widths')}: ${p.widthsCm.join(' / ')} سم'),
                            if (p.colors.isNotEmpty)
                              Text('${s.t('الألوان', 'Colors')}: ${p.colors.join(', ')}'),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
