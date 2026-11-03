import 'package:eg_mobile/core/data/seed_data.dart';
import 'package:eg_mobile/features/production/data/models/work_order_model.dart';
import 'package:eg_mobile/features/sales/data/models/sales_order_model.dart';
import '../../domain/entities/dashboard_entity.dart';

abstract class DashboardLocalDataSource {
  Future<DashboardEntity> getDashboard();
}

class DashboardLocalDataSourceImpl implements DashboardLocalDataSource {
  @override
  Future<DashboardEntity> getDashboard() async {
    final openSales = seedSalesOrders
        .where((o) => o.status != 'shipped' && o.status != 'draft')
        .length;
    final wip = seedWorkOrders
        .where((w) => w.status == 'in_progress' || w.status == 'queued')
        .length;
    final low = seedInventory.where((row) {
      final p = seedProductById(row.productId);
      return p != null && row.available < p.minStock;
    }).length;

    return DashboardEntity(
      monthSales: seedFinance.monthSales,
      openSalesCount: openSales,
      wipCount: wip,
      lowStockCount: low,
      receivables: seedFinance.receivables,
      cash: seedFinance.cash,
      latestSales: seedSalesOrders
          .take(3)
          .map(SalesOrderModel.fromSeed)
          .map((m) => m.toEntity())
          .toList(),
      workOrders: seedWorkOrders
          .map(WorkOrderModel.fromSeed)
          .map((m) => m.toEntity())
          .toList(),
    );
  }
}
