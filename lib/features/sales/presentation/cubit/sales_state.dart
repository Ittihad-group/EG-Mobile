import 'package:equatable/equatable.dart';
import '../../domain/entities/sales_order_entity.dart';

abstract class SalesState extends Equatable {
  const SalesState();
  @override
  List<Object?> get props => [];
}

class SalesInitial extends SalesState { const SalesInitial(); }
class SalesLoading extends SalesState { const SalesLoading(); }
class SalesLoaded extends SalesState {
  const SalesLoaded(this.orders);
  final List<SalesOrderEntity> orders;
  @override
  List<Object?> get props => [orders];
}
class SalesError extends SalesState {
  const SalesError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
