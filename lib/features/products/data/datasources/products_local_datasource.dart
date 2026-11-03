import 'package:eg_mobile/core/data/seed_data.dart';

import '../models/product_model.dart';

abstract class ProductsLocalDataSource {
  Future<List<ProductModel>> getProducts({String query = ''});
  Future<ProductModel?> getProductById(String id);
}

class ProductsLocalDataSourceImpl implements ProductsLocalDataSource {
  @override
  Future<List<ProductModel>> getProducts({String query = ''}) async {
    final term = query.trim().toLowerCase();
    final list = seedProducts.map(ProductModel.fromSeed).where((p) {
      if (term.isEmpty) return true;
      return p.sku.toLowerCase().contains(term) ||
          p.nameAr.contains(query) ||
          p.nameEn.toLowerCase().contains(term);
    }).toList();
    return list;
  }

  @override
  Future<ProductModel?> getProductById(String id) async {
    final p = seedProductById(id);
    return p == null ? null : ProductModel.fromSeed(p);
  }
}
