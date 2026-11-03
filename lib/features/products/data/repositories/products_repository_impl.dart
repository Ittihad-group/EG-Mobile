import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/products_repository.dart';
import '../datasources/products_local_datasource.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  ProductsRepositoryImpl(this._local);

  final ProductsLocalDataSource _local;

  @override
  Future<List<ProductEntity>> getProducts({String query = ''}) async {
    final models = await _local.getProducts(query: query);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<ProductEntity?> getProductById(String id) async {
    final model = await _local.getProductById(id);
    return model?.toEntity();
  }
}
