import 'package:eg_mobile/core/data/seed_data.dart';
import '../models/sales_order_model.dart';

abstract class SalesLocalDataSource {
  Future<List<SalesOrderModel>> getOrders();
}

class SalesLocalDataSourceImpl implements SalesLocalDataSource {
  @override
  Future<List<SalesOrderModel>> getOrders() async =>
      seedSalesOrders.map(SalesOrderModel.fromSeed).toList();
}
