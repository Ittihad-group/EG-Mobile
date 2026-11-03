import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';
import '../network/dio_client.dart';
import '../network/network_info.dart';
import '../storage/local_storage.dart';
import '../storage/secure_storage.dart';
import '../../features/auth/data/datasources/auth_local_datasource.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/customers/data/datasources/customers_local_datasource.dart';
import '../../features/customers/data/repositories/customers_repository_impl.dart';
import '../../features/customers/domain/repositories/customers_repository.dart';
import '../../features/customers/presentation/cubit/customers_cubit.dart';
import '../../features/dashboard/data/datasources/dashboard_local_datasource.dart';
import '../../features/dashboard/data/repositories/dashboard_repository_impl.dart';
import '../../features/dashboard/domain/repositories/dashboard_repository.dart';
import '../../features/dashboard/presentation/cubit/dashboard_cubit.dart';
import '../../features/finance/data/datasources/finance_local_datasource.dart';
import '../../features/finance/data/repositories/finance_repository_impl.dart';
import '../../features/finance/domain/repositories/finance_repository.dart';
import '../../features/finance/presentation/cubit/finance_cubit.dart';
import '../../features/inventory/data/datasources/inventory_local_datasource.dart';
import '../../features/inventory/data/repositories/inventory_repository_impl.dart';
import '../../features/inventory/domain/repositories/inventory_repository.dart';
import '../../features/inventory/presentation/cubit/inventory_cubit.dart';
import '../../features/locale/presentation/cubit/locale_cubit.dart';
import '../../features/production/data/datasources/production_local_datasource.dart';
import '../../features/production/data/repositories/production_repository_impl.dart';
import '../../features/production/domain/repositories/production_repository.dart';
import '../../features/production/presentation/cubit/production_cubit.dart';
import '../../features/products/data/datasources/products_local_datasource.dart';
import '../../features/products/data/repositories/products_repository_impl.dart';
import '../../features/products/domain/repositories/products_repository.dart';
import '../../features/products/presentation/cubit/products_cubit.dart';
import '../../features/sales/data/datasources/sales_local_datasource.dart';
import '../../features/sales/data/repositories/sales_repository_impl.dart';
import '../../features/sales/domain/repositories/sales_repository.dart';
import '../../features/sales/presentation/cubit/sales_cubit.dart';

final sl = GetIt.instance;

Future<void> initDependencies({
  AppConfig config = AppConfig.development,
}) async {
  // External
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);
  sl.registerLazySingleton<AppConfig>(() => config);

  // Core
  sl.registerLazySingleton<LocalStorage>(
    () => LocalStorageImpl(sl()),
  );
  sl.registerLazySingleton<SecureStorage>(() => SecureStorageImpl());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  sl.registerLazySingleton<DioClient>(() => DioClient(sl()));

  // Locale
  sl.registerFactory(() => LocaleCubit(localStorage: sl()));

  // Auth
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(
      localStorage: sl(),
      secureStorage: sl(),
    ),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerFactory(
    () => AuthCubit(
      loginUseCase: sl(),
      logoutUseCase: sl(),
      authRepository: sl(),
    ),
  );

  // Products
  sl.registerLazySingleton<ProductsLocalDataSource>(
    () => ProductsLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(sl()),
  );
  sl.registerFactory(() => ProductsCubit(sl()));

  // Inventory
  sl.registerLazySingleton<InventoryLocalDataSource>(
    () => InventoryLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<InventoryRepository>(
    () => InventoryRepositoryImpl(sl()),
  );
  sl.registerFactory(() => InventoryCubit(sl()));

  // Sales
  sl.registerLazySingleton<SalesLocalDataSource>(
    () => SalesLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<SalesRepository>(
    () => SalesRepositoryImpl(sl()),
  );
  sl.registerFactory(() => SalesCubit(sl()));

  // Production
  sl.registerLazySingleton<ProductionLocalDataSource>(
    () => ProductionLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<ProductionRepository>(
    () => ProductionRepositoryImpl(sl()),
  );
  sl.registerFactory(() => ProductionCubit(sl()));

  // Customers
  sl.registerLazySingleton<CustomersLocalDataSource>(
    () => CustomersLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<CustomersRepository>(
    () => CustomersRepositoryImpl(sl()),
  );
  sl.registerFactory(() => CustomersCubit(sl()));

  // Finance
  sl.registerLazySingleton<FinanceLocalDataSource>(
    () => FinanceLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<FinanceRepository>(
    () => FinanceRepositoryImpl(sl()),
  );
  sl.registerFactory(() => FinanceCubit(sl()));

  // Dashboard
  sl.registerLazySingleton<DashboardLocalDataSource>(
    () => DashboardLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(sl()),
  );
  sl.registerFactory(() => DashboardCubit(sl()));
}
