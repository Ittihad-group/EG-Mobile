import '../entities/customer_entity.dart';

abstract class CustomersRepository {
  Future<List<CustomerEntity>> getCustomers();
}
