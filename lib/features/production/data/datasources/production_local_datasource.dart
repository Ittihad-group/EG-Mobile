import 'package:eg_mobile/core/data/seed_data.dart';
import '../models/work_order_model.dart';

abstract class ProductionLocalDataSource {
  Future<List<WorkOrderModel>> getWorkOrders();
}

class ProductionLocalDataSourceImpl implements ProductionLocalDataSource {
  @override
  Future<List<WorkOrderModel>> getWorkOrders() async =>
      seedWorkOrders.map(WorkOrderModel.fromSeed).toList();
}
