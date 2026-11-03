import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/customers_repository.dart';
import 'customers_state.dart';

class CustomersCubit extends Cubit<CustomersState> {
  CustomersCubit(this._repository) : super(const CustomersInitial());
  final CustomersRepository _repository;

  Future<void> load() async {
    emit(const CustomersLoading());
    try {
      emit(CustomersLoaded(await _repository.getCustomers()));
    } catch (e) {
      emit(CustomersError(e.toString()));
    }
  }
}
