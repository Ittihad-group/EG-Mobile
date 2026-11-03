import 'package:equatable/equatable.dart';
import '../../domain/entities/finance_summary_entity.dart';

abstract class FinanceState extends Equatable {
  const FinanceState();
  @override
  List<Object?> get props => [];
}

class FinanceInitial extends FinanceState { const FinanceInitial(); }
class FinanceLoading extends FinanceState { const FinanceLoading(); }
class FinanceLoaded extends FinanceState {
  const FinanceLoaded(this.summary);
  final FinanceSummaryEntity summary;
  @override
  List<Object?> get props => [summary];
}
class FinanceError extends FinanceState {
  const FinanceError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
