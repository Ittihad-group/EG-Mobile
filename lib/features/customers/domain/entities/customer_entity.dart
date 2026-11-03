import 'package:equatable/equatable.dart';

class CustomerEntity extends Equatable {
  const CustomerEntity({
    required this.id,
    required this.code,
    required this.nameAr,
    required this.nameEn,
    required this.type,
    required this.cityAr,
    required this.cityEn,
    required this.balance,
    required this.phone,
  });

  final String id;
  final String code;
  final String nameAr;
  final String nameEn;
  final String type;
  final String cityAr;
  final String cityEn;
  final double balance;
  final String phone;

  @override
  List<Object?> get props => [id, code, balance];
}
