import 'package:eg_mobile/core/data/seed_data.dart';
import '../models/customer_model.dart';

abstract class CustomersLocalDataSource {
  Future<List<CustomerModel>> getCustomers();
}

class CustomersLocalDataSourceImpl implements CustomersLocalDataSource {
  @override
  Future<List<CustomerModel>> getCustomers() async =>
      seedCustomers.map(CustomerModel.fromSeed).toList();
}
