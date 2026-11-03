import 'package:equatable/equatable.dart';

class SalesOrderEntity extends Equatable {
  const SalesOrderEntity({
    required this.id,
    required this.number,
    required this.customerAr,
    required this.customerEn,
    required this.date,
    required this.status,
    required this.total,
  });

  final String id;
  final String number;
  final String customerAr;
  final String customerEn;
  final String date;
  final String status;
  final double total;

  @override
  List<Object?> get props => [id, number, status, total];
}
