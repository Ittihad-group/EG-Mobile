import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/inventory_repository.dart';
import 'inventory_state.dart';

class InventoryCubit extends Cubit<InventoryState> {
  InventoryCubit(this._repository) : super(const InventoryInitial());
  final InventoryRepository _repository;

  Future<void> load() async {
    emit(const InventoryLoading());
    try {
      emit(InventoryLoaded(await _repository.getInventory()));
    } catch (e) {
      emit(InventoryError(e.toString()));
    }
  }
}
