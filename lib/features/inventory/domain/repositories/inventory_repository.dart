import '../entities/stock_entity.dart';

abstract class InventoryRepository {
  Future<List<StockEntity>> getInventory();
}
