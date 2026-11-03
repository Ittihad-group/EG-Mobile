import 'package:equatable/equatable.dart';

import '../../domain/entities/product_entity.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();
  @override
  List<Object?> get props => [];
}

class ProductsInitial extends ProductsState {
  const ProductsInitial();
}

class ProductsLoading extends ProductsState {
  const ProductsLoading();
}

class ProductsLoaded extends ProductsState {
  const ProductsLoaded(this.products, {this.query = ''});
  final List<ProductEntity> products;
  final String query;
  @override
  List<Object?> get props => [products, query];
}

class ProductsError extends ProductsState {
  const ProductsError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
