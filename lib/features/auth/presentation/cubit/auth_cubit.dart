import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required LoginUseCase loginUseCase,
    required LogoutUseCase logoutUseCase,
    required AuthRepository authRepository,
  })  : _loginUseCase = loginUseCase,
        _logoutUseCase = logoutUseCase,
        _authRepository = authRepository,
        super(const AuthInitial());

  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final AuthRepository _authRepository;

  Future<void> checkSession() async {
    emit(const AuthLoading());
    final user = await _authRepository.getCurrentUser();
    if (user != null) {
      emit(AuthAuthenticated(user));
    } else {
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const AuthLoading());
    try {
      final user = await _loginUseCase(email: email, password: password);
      emit(AuthAuthenticated(user));
    } on Failure catch (f) {
      emit(AuthError(f.message));
      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> logout() async {
    emit(const AuthLoading());
    try {
      await _logoutUseCase();
    } finally {
      emit(const AuthUnauthenticated());
    }
  }
}
