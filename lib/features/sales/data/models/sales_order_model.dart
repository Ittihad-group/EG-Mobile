import 'package:eg_mobile/core/data/seed_data.dart';
import '../../domain/entities/sales_order_entity.dart';

class SalesOrderModel extends SalesOrderEntity {
  const SalesOrderModel({
    required super.id,
    required super.number,
    required super.customerAr,
    required super.customerEn,
    required super.date,
    required super.status,
    required super.total,
  });

  factory SalesOrderModel.fromSeed(SeedSalesOrder o) => SalesOrderModel(
        id: o.id,
        number: o.number,
        customerAr: o.customerAr,
        customerEn: o.customerEn,
        date: o.date,
        status: o.status,
        total: o.total,
      );

  SalesOrderEntity toEntity() => SalesOrderEntity(
        id: id,
        number: number,
        customerAr: customerAr,
        customerEn: customerEn,
        date: date,
        status: status,
        total: total,
      );
}
