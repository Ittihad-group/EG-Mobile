import 'package:eg_mobile/core/data/seed_data.dart';
import '../../domain/entities/customer_entity.dart';

class CustomerModel extends CustomerEntity {
  const CustomerModel({
    required super.id,
    required super.code,
    required super.nameAr,
    required super.nameEn,
    required super.type,
    required super.cityAr,
    required super.cityEn,
    required super.balance,
    required super.phone,
  });

  factory CustomerModel.fromSeed(SeedCustomer c) => CustomerModel(
        id: c.id,
        code: c.code,
        nameAr: c.nameAr,
        nameEn: c.nameEn,
        type: c.type,
        cityAr: c.cityAr,
        cityEn: c.cityEn,
        balance: c.balance,
        phone: c.phone,
      );

  CustomerEntity toEntity() => CustomerEntity(
        id: id,
        code: code,
        nameAr: nameAr,
        nameEn: nameEn,
        type: type,
        cityAr: cityAr,
        cityEn: cityEn,
        balance: balance,
        phone: phone,
      );
}
