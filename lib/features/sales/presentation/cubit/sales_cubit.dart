import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/sales_repository.dart';
import 'sales_state.dart';

class SalesCubit extends Cubit<SalesState> {
  SalesCubit(this._repository) : super(const SalesInitial());
  final SalesRepository _repository;

  Future<void> load() async {
    emit(const SalesLoading());
    try {
      emit(SalesLoaded(await _repository.getOrders()));
    } catch (e) {
      emit(SalesError(e.toString()));
    }
  }
}
