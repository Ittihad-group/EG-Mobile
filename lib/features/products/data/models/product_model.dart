import 'package:eg_mobile/core/data/seed_data.dart';

import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.sku,
    required super.nameAr,
    required super.nameEn,
    required super.categoryAr,
    required super.categoryEn,
    required super.price,
    required super.cost,
    required super.minStock,
    required super.widthsCm,
    required super.colors,
  });

  factory ProductModel.fromSeed(SeedProduct p) => ProductModel(
        id: p.id,
        sku: p.sku,
        nameAr: p.nameAr,
        nameEn: p.nameEn,
        categoryAr: p.categoryAr,
        categoryEn: p.categoryEn,
        price: p.price,
        cost: p.cost,
        minStock: p.minStock,
        widthsCm: p.widthsCm,
        colors: p.colors,
      );

  ProductEntity toEntity() => ProductEntity(
        id: id,
        sku: sku,
        nameAr: nameAr,
        nameEn: nameEn,
        categoryAr: categoryAr,
        categoryEn: categoryEn,
        price: price,
        cost: cost,
        minStock: minStock,
        widthsCm: widthsCm,
        colors: colors,
      );
}
