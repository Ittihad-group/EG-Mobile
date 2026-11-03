import 'package:eg_mobile/core/data/seed_data.dart';
import 'package:eg_mobile/features/products/data/models/product_model.dart';

import '../../domain/entities/stock_entity.dart';

class StockModel extends StockEntity {
  const StockModel({
    required super.id,
    required super.productId,
    required super.warehouseAr,
    required super.warehouseEn,
    required super.qty,
    required super.reserved,
    super.product,
  });

  factory StockModel.fromSeed(SeedStockRow row, {ProductModel? product}) {
    return StockModel(
      id: row.id,
      productId: row.productId,
      warehouseAr: row.warehouseAr,
      warehouseEn: row.warehouseEn,
      qty: row.qty,
      reserved: row.reserved,
      product: product?.toEntity(),
    );
  }

  StockEntity toEntity() => StockEntity(
        id: id,
        productId: productId,
        warehouseAr: warehouseAr,
        warehouseEn: warehouseEn,
        qty: qty,
        reserved: reserved,
        product: product,
      );
}
