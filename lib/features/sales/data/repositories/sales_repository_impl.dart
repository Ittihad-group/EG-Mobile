import '../../domain/entities/sales_order_entity.dart';
import '../../domain/repositories/sales_repository.dart';
import '../datasources/sales_local_datasource.dart';

class SalesRepositoryImpl implements SalesRepository {
  SalesRepositoryImpl(this._local);
  final SalesLocalDataSource _local;

  @override
  Future<List<SalesOrderEntity>> getOrders() async {
    final models = await _local.getOrders();
    return models.map((m) => m.toEntity()).toList();
  }
}
