import '../../domain/entities/stock_entity.dart';
import '../../domain/repositories/inventory_repository.dart';
import '../datasources/inventory_local_datasource.dart';

class InventoryRepositoryImpl implements InventoryRepository {
  InventoryRepositoryImpl(this._local);
  final InventoryLocalDataSource _local;

  @override
  Future<List<StockEntity>> getInventory() async {
    final models = await _local.getInventory();
    return models.map((m) => m.toEntity()).toList();
  }
}
