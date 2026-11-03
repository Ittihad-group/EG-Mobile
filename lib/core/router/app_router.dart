import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/auth/presentation/cubit/auth_state.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/shell/presentation/pages/shell_page.dart';

class AppRoutes {
  const AppRoutes._();

  static const login = '/login';
  static const home = '/';
}

GoRouter createAppRouter(AuthCubit authCubit) {
  return GoRouter(
    initialLocation: AppRoutes.login,
    refreshListenable: AuthRouterRefresh(authCubit),
    redirect: (context, state) {
      final authState = authCubit.state;
      final loggingIn = state.matchedLocation == AppRoutes.login;

      if (authState is AuthInitial || authState is AuthLoading) {
        return null;
      }

      final authenticated = authState is AuthAuthenticated;

      if (!authenticated && !loggingIn) return AppRoutes.login;
      if (authenticated && loggingIn) return AppRoutes.home;
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const ShellPage(),
      ),
    ],
  );
}

class AuthRouterRefresh extends ChangeNotifier {
  AuthRouterRefresh(this._authCubit) {
    _subscription = _authCubit.stream.listen((_) => notifyListeners());
  }

  final AuthCubit _authCubit;
  late final StreamSubscription<AuthState> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
