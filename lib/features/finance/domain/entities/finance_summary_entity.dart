import 'package:equatable/equatable.dart';
import '../../../customers/domain/entities/customer_entity.dart';

class FinanceSummaryEntity extends Equatable {
  const FinanceSummaryEntity({
    required this.monthSales,
    required this.receivables,
    required this.payables,
    required this.cash,
    this.customerBalances = const [],
  });

  final double monthSales;
  final double receivables;
  final double payables;
  final double cash;
  final List<CustomerEntity> customerBalances;

  @override
  List<Object?> get props => [monthSales, receivables, payables, cash, customerBalances];
}
