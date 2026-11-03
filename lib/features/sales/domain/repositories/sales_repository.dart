import '../entities/sales_order_entity.dart';

abstract class SalesRepository {
  Future<List<SalesOrderEntity>> getOrders();
}
