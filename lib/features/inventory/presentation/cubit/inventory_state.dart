import 'package:equatable/equatable.dart';
import '../../domain/entities/stock_entity.dart';

abstract class InventoryState extends Equatable {
  const InventoryState();
  @override
  List<Object?> get props => [];
}

class InventoryInitial extends InventoryState { const InventoryInitial(); }
class InventoryLoading extends InventoryState { const InventoryLoading(); }
class InventoryLoaded extends InventoryState {
  const InventoryLoaded(this.items);
  final List<StockEntity> items;
  @override
  List<Object?> get props => [items];
}
class InventoryError extends InventoryState {
  const InventoryError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
