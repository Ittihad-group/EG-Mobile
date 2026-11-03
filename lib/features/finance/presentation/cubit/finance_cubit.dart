import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/finance_repository.dart';
import 'finance_state.dart';

class FinanceCubit extends Cubit<FinanceState> {
  FinanceCubit(this._repository) : super(const FinanceInitial());
  final FinanceRepository _repository;

  Future<void> load() async {
    emit(const FinanceLoading());
    try {
      emit(FinanceLoaded(await _repository.getSummary()));
    } catch (e) {
      emit(FinanceError(e.toString()));
    }
  }
}
