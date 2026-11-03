import 'package:eg_mobile/core/errors/exceptions.dart';
import 'package:eg_mobile/core/network/api_endpoints.dart';
import 'package:eg_mobile/core/network/dio_client.dart';

import '../models/user_model.dart';

/// Remote auth API. Not used while the app runs on local seed auth.
abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String email, required String password});
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._client);

  final DioClient _client;

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.dio.post(
        ApiEndpoints.authLogin,
        data: {'email': email, 'password': password},
      );
      return UserModel.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _client.dio.post(ApiEndpoints.authLogout);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
