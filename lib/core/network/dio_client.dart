import 'package:dio/dio.dart';

import '../config/app_config.dart';

class DioClient {
  DioClient(this._config) {
    _dio = Dio(
      BaseOptions(
        baseUrl: _config.apiBaseUrl,
        connectTimeout: Duration(seconds: _config.apiTimeoutSeconds),
        receiveTimeout: Duration(seconds: _config.apiTimeoutSeconds),
        headers: const {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  final AppConfig _config;
  late final Dio _dio;

  Dio get dio => _dio;

  void setAuthToken(String? token) {
    if (token == null || token.isEmpty) {
      _dio.options.headers.remove('Authorization');
    } else {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }
}
