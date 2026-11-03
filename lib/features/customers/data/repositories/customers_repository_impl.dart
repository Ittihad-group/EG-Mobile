import '../../domain/entities/customer_entity.dart';
import '../../domain/repositories/customers_repository.dart';
import '../datasources/customers_local_datasource.dart';

class CustomersRepositoryImpl implements CustomersRepository {
  CustomersRepositoryImpl(this._local);
  final CustomersLocalDataSource _local;

  @override
  Future<List<CustomerEntity>> getCustomers() async {
    final models = await _local.getCustomers();
    return models.map((m) => m.toEntity()).toList();
  }
}
