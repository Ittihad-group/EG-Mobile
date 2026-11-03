import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/login_screen.dart';
import 'screens/shell_screen.dart';
import 'state/app_state.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const EgMobileApp());
}

class EgMobileApp extends StatefulWidget {
  const EgMobileApp({super.key});

  @override
  State<EgMobileApp> createState() => _EgMobileAppState();
}

class _EgMobileAppState extends State<EgMobileApp> {
  final AppState state = AppState();

  @override
  void initState() {
    super.initState();
    state.addListener(_onChange);
  }

  void _onChange() => setState(() {});

  @override
  void dispose() {
    state.removeListener(_onChange);
    state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EG-Mobile ERP',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(state.isArabic),
      locale: Locale(state.isArabic ? 'ar' : 'en'),
      supportedLocales: const [Locale('ar'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      builder: (context, child) {
        return Directionality(
          textDirection: state.isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: state.isLoggedIn ? ShellScreen(state: state) : LoginScreen(state: state),
    );
  }
}
