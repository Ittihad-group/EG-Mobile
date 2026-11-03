import 'package:eg_mobile/core/data/seed_data.dart';
import 'package:eg_mobile/features/customers/domain/entities/customer_entity.dart';
import '../../domain/entities/finance_summary_entity.dart';

class FinanceSummaryModel extends FinanceSummaryEntity {
  const FinanceSummaryModel({
    required super.monthSales,
    required super.receivables,
    required super.payables,
    required super.cash,
    super.customerBalances,
  });

  factory FinanceSummaryModel.fromSeed(
    SeedFinanceSummary f, {
    List<CustomerEntity> balances = const [],
  }) =>
      FinanceSummaryModel(
        monthSales: f.monthSales,
        receivables: f.receivables,
        payables: f.payables,
        cash: f.cash,
        customerBalances: balances,
      );

  FinanceSummaryEntity toEntity() => FinanceSummaryEntity(
        monthSales: monthSales,
        receivables: receivables,
        payables: payables,
        cash: cash,
        customerBalances: customerBalances,
      );
}
