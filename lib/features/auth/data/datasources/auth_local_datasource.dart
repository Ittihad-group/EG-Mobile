import 'dart:convert';

import 'package:eg_mobile/core/data/seed_data.dart';
import 'package:eg_mobile/core/errors/exceptions.dart';
import 'package:eg_mobile/core/storage/local_storage.dart';
import 'package:eg_mobile/core/storage/secure_storage.dart';

import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel> login({required String email, required String password});
  Future<void> cacheUser(UserModel user);
  Future<UserModel?> getCachedUser();
  Future<void> clearSession();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl({
    required LocalStorage localStorage,
    required SecureStorage secureStorage,
  })  : _localStorage = localStorage,
        _secureStorage = secureStorage;

  static const _userKey = 'auth_user';
  static const _tokenKey = 'auth_token';

  final LocalStorage _localStorage;
  final SecureStorage _secureStorage;

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    for (final user in seedUsers) {
      if (user.email == email.trim() && user.password == password) {
        return UserModel.fromSeed(
          id: user.id,
          nameAr: user.nameAr,
          nameEn: user.nameEn,
          email: user.email,
          role: user.role,
          password: user.password,
        );
      }
    }
    throw const AuthException('Invalid credentials');
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    await _localStorage.setString(_userKey, jsonEncode(user.toJson()));
    await _secureStorage.write(_tokenKey, 'demo-token-${user.id}');
  }

  @override
  Future<UserModel?> getCachedUser() async {
    final raw = await _localStorage.getString(_userKey);
    if (raw == null) return null;
    return UserModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  @override
  Future<void> clearSession() async {
    await _localStorage.remove(_userKey);
    await _secureStorage.delete(_tokenKey);
  }
}
