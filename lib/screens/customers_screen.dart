import 'package:flutter/material.dart';
import '../data/seed.dart';
import '../state/app_state.dart';

class CustomersScreen extends StatelessWidget {
  final AppState state;
  const CustomersScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final s = state;
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: customers.length,
      itemBuilder: (_, i) {
        final c = customers[i];
        return Card(
          child: ListTile(
            title: Text(s.t(c.nameAr, c.nameEn), style: const TextStyle(fontWeight: FontWeight.w700)),
            subtitle: Text('${c.code} · ${s.statusLabel(c.type)} · ${s.t(c.cityAr, c.cityEn)}\n${c.phone}'),
            isThreeLine: true,
            trailing: Text(s.money(c.balance), style: const TextStyle(fontWeight: FontWeight.w800)),
          ),
        );
      },
    );
  }
}
