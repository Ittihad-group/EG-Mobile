import '../entities/product_entity.dart';

abstract class ProductsRepository {
  Future<List<ProductEntity>> getProducts({String query = ''});
  Future<ProductEntity?> getProductById(String id);
}
