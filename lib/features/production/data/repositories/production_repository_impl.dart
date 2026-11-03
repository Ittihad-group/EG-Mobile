import '../../domain/entities/work_order_entity.dart';
import '../../domain/repositories/production_repository.dart';
import '../datasources/production_local_datasource.dart';

class ProductionRepositoryImpl implements ProductionRepository {
  ProductionRepositoryImpl(this._local);
  final ProductionLocalDataSource _local;

  @override
  Future<List<WorkOrderEntity>> getWorkOrders() async {
    final models = await _local.getWorkOrders();
    return models.map((m) => m.toEntity()).toList();
  }
}
