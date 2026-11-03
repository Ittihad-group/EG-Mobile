import '../../domain/entities/finance_summary_entity.dart';
import '../../domain/repositories/finance_repository.dart';
import '../datasources/finance_local_datasource.dart';

class FinanceRepositoryImpl implements FinanceRepository {
  FinanceRepositoryImpl(this._local);
  final FinanceLocalDataSource _local;

  @override
  Future<FinanceSummaryEntity> getSummary() async {
    final model = await _local.getSummary();
    return model.toEntity();
  }
}
