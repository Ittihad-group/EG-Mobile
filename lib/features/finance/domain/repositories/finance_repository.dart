import '../entities/finance_summary_entity.dart';

abstract class FinanceRepository {
  Future<FinanceSummaryEntity> getSummary();
}
