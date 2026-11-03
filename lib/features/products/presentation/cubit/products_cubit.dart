import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/products_repository.dart';
import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this._repository) : super(const ProductsInitial());

  final ProductsRepository _repository;

  Future<void> load({String query = ''}) async {
    emit(const ProductsLoading());
    try {
      final products = await _repository.getProducts(query: query);
      emit(ProductsLoaded(products, query: query));
    } catch (e) {
      emit(ProductsError(e.toString()));
    }
  }

  Future<void> search(String query) => load(query: query);
}
