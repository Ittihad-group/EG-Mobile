import 'package:equatable/equatable.dart';

import '../../../products/domain/entities/product_entity.dart';

class StockEntity extends Equatable {
  const StockEntity({
    required this.id,
    required this.productId,
    required this.warehouseAr,
    required this.warehouseEn,
    required this.qty,
    required this.reserved,
    this.product,
  });

  final String id;
  final String productId;
  final String warehouseAr;
  final String warehouseEn;
  final int qty;
  final int reserved;
  final ProductEntity? product;

  int get available => qty - reserved;

  bool get isLowStock =>
      product != null && available < product!.minStock;

  @override
  List<Object?> get props => [id, productId, qty, reserved];
}
