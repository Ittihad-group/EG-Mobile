import 'package:flutter/material.dart';
import '../data/seed.dart';
import '../state/app_state.dart';
import '../widgets/status_chip.dart';

class SalesScreen extends StatelessWidget {
  final AppState state;
  const SalesScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final s = state;
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: salesOrders.length,
      itemBuilder: (_, i) {
        final o = salesOrders[i];
        return Card(
          child: ListTile(
            title: Text(o.number, style: const TextStyle(fontWeight: FontWeight.w800)),
            subtitle: Text('${s.t(o.customerAr, o.customerEn)}\n${o.date}'),
            isThreeLine: true,
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                StatusChip(label: s.statusLabel(o.status), status: o.status),
                const SizedBox(height: 6),
                Text(s.money(o.total), style: const TextStyle(fontWeight: FontWeight.w800)),
              ],
            ),
          ),
        );
      },
    );
  }
}
