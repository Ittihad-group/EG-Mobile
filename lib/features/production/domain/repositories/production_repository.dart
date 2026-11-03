import '../entities/work_order_entity.dart';

abstract class ProductionRepository {
  Future<List<WorkOrderEntity>> getWorkOrders();
}
