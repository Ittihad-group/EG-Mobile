import 'package:equatable/equatable.dart';
import '../../domain/entities/work_order_entity.dart';

abstract class ProductionState extends Equatable {
  const ProductionState();
  @override
  List<Object?> get props => [];
}

class ProductionInitial extends ProductionState { const ProductionInitial(); }
class ProductionLoading extends ProductionState { const ProductionLoading(); }
class ProductionLoaded extends ProductionState {
  const ProductionLoaded(this.orders);
  final List<WorkOrderEntity> orders;
  @override
  List<Object?> get props => [orders];
}
class ProductionError extends ProductionState {
  const ProductionError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
