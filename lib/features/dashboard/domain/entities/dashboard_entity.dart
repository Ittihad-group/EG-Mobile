import 'package:equatable/equatable.dart';
import '../../../production/domain/entities/work_order_entity.dart';
import '../../../sales/domain/entities/sales_order_entity.dart';

class DashboardEntity extends Equatable {
  const DashboardEntity({
    required this.monthSales,
    required this.openSalesCount,
    required this.wipCount,
    required this.lowStockCount,
    required this.receivables,
    required this.cash,
    required this.latestSales,
    required this.workOrders,
  });

  final double monthSales;
  final int openSalesCount;
  final int wipCount;
  final int lowStockCount;
  final double receivables;
  final double cash;
  final List<SalesOrderEntity> latestSales;
  final List<WorkOrderEntity> workOrders;

  @override
  List<Object?> get props => [
        monthSales,
        openSalesCount,
        wipCount,
        lowStockCount,
        receivables,
        cash,
        latestSales,
        workOrders,
      ];
}
