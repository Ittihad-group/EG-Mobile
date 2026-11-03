import 'package:eg_mobile/core/data/seed_data.dart';
import 'package:eg_mobile/features/customers/data/models/customer_model.dart';
import '../models/finance_summary_model.dart';

abstract class FinanceLocalDataSource {
  Future<FinanceSummaryModel> getSummary();
}

class FinanceLocalDataSourceImpl implements FinanceLocalDataSource {
  @override
  Future<FinanceSummaryModel> getSummary() async {
    final balances = seedCustomers
        .where((c) => c.balance > 0)
        .map(CustomerModel.fromSeed)
        .map((m) => m.toEntity())
        .toList();
    return FinanceSummaryModel.fromSeed(seedFinance, balances: balances);
  }
}
