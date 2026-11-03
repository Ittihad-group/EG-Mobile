import 'package:flutter/material.dart';
import '../data/seed.dart';
import '../state/app_state.dart';

class InventoryScreen extends StatelessWidget {
  final AppState state;
  const InventoryScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final s = state;
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: inventory.length,
      itemBuilder: (_, i) {
        final row = inventory[i];
        final p = productById(row.productId);
        final low = p != null && row.available < p.minStock;
        return Card(
          child: ListTile(
            title: Text(
              p == null ? row.productId : s.t(p.nameAr, p.nameEn),
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            subtitle: Text(
              '${p?.sku ?? ''} · ${s.t(row.warehouseAr, row.warehouseEn)}\n'
              '${s.t('رصيد', 'Stock')}: ${row.qty} · ${s.t('محجوز', 'Reserved')}: ${row.reserved}',
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
                  s.t('متاح', 'Avail'),
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
                if (low)
                  Text(s.t('منخفض', 'Low'), style: const TextStyle(color: Colors.red, fontSize: 11, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        );
      },
    );
  }
}
