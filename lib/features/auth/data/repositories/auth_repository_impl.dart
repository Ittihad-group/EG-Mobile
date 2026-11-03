import 'package:eg_mobile/core/errors/exceptions.dart';
import 'package:eg_mobile/core/errors/failures.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required AuthLocalDataSource localDataSource})
      : _local = localDataSource;

  final AuthLocalDataSource _local;

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _local.login(email: email, password: password);
      await _local.cacheUser(user);
      return user.toEntity();
    } on AuthException catch (e) {
      throw AuthFailure(e.message);
    } catch (e) {
      throw UnexpectedFailure(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _local.clearSession();
    } catch (e) {
      throw CacheFailure(e.toString());
    }
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      final user = await _local.getCachedUser();
      return user?.toEntity();
    } catch (_) {
      return null;
    }
  }
}
