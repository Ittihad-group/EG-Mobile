import 'package:equatable/equatable.dart';
import '../../domain/entities/customer_entity.dart';

abstract class CustomersState extends Equatable {
  const CustomersState();
  @override
  List<Object?> get props => [];
}

class CustomersInitial extends CustomersState { const CustomersInitial(); }
class CustomersLoading extends CustomersState { const CustomersLoading(); }
class CustomersLoaded extends CustomersState {
  const CustomersLoaded(this.customers);
  final List<CustomerEntity> customers;
  @override
  List<Object?> get props => [customers];
}
class CustomersError extends CustomersState {
  const CustomersError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
