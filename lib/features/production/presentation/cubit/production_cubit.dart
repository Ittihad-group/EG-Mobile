import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/production_repository.dart';
import 'production_state.dart';

class ProductionCubit extends Cubit<ProductionState> {
  ProductionCubit(this._repository) : super(const ProductionInitial());
  final ProductionRepository _repository;

  Future<void> load() async {
    emit(const ProductionLoading());
    try {
      emit(ProductionLoaded(await _repository.getWorkOrders()));
    } catch (e) {
      emit(ProductionError(e.toString()));
    }
  }
}
