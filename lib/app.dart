import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import 'core/di/injection_container.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/locale/presentation/cubit/locale_cubit.dart';
import 'features/locale/presentation/cubit/locale_state.dart';

class EgMobileApp extends StatefulWidget {
  const EgMobileApp({super.key});

  @override
  State<EgMobileApp> createState() => _EgMobileAppState();
}

class _EgMobileAppState extends State<EgMobileApp> {
  late final AuthCubit _authCubit;
  late final LocaleCubit _localeCubit;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _authCubit = sl<AuthCubit>()..checkSession();
    _localeCubit = sl<LocaleCubit>()..load();
    _router = createAppRouter(_authCubit);
  }

  @override
  void dispose() {
    _authCubit.close();
    _localeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _authCubit),
        BlocProvider.value(value: _localeCubit),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, locale) {
          return MaterialApp.router(
            title: 'EG-Mobile ERP',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(isArabic: locale.isArabic),
            locale: Locale(locale.isArabic ? 'ar' : 'en'),
            supportedLocales: const [Locale('ar'), Locale('en')],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            builder: (context, child) {
              return Directionality(
                textDirection:
                    locale.isArabic ? TextDirection.rtl : TextDirection.ltr,
                child: child ?? const SizedBox.shrink(),
              );
            },
            routerConfig: _router,
          );
        },
      ),
    );
  }
}
