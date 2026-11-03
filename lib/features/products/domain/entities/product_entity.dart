import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  const ProductEntity({
    required this.id,
    required this.sku,
    required this.nameAr,
    required this.nameEn,
    required this.categoryAr,
    required this.categoryEn,
    required this.price,
    required this.cost,
    required this.minStock,
    required this.widthsCm,
    required this.colors,
  });

  final String id;
  final String sku;
  final String nameAr;
  final String nameEn;
  final String categoryAr;
  final String categoryEn;
  final double price;
  final double cost;
  final int minStock;
  final List<int> widthsCm;
  final List<String> colors;

  @override
  List<Object?> get props => [id, sku, nameAr, nameEn, price];
}
