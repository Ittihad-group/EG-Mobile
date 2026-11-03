import 'package:eg_mobile/core/data/seed_data.dart';
import 'package:eg_mobile/features/products/data/models/product_model.dart';

import '../models/stock_model.dart';

abstract class InventoryLocalDataSource {
  Future<List<StockModel>> getInventory();
}

class InventoryLocalDataSourceImpl implements InventoryLocalDataSource {
  @override
  Future<List<StockModel>> getInventory() async {
    return seedInventory.map((row) {
      final seed = seedProductById(row.productId);
      final product = seed == null ? null : ProductModel.fromSeed(seed);
      return StockModel.fromSeed(row, product: product);
    }).toList();
  }
}
