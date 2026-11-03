import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/company_info.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../../../locale/presentation/cubit/locale_cubit.dart';
import '../../../locale/presentation/cubit/locale_state.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailCtrl = TextEditingController(text: 'admin@egerman-upvc.com');
  final passCtrl = TextEditingController(text: 'admin123');

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    context.read<AuthCubit>().login(
          email: emailCtrl.text,
          password: passCtrl.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, locale) {
        final isArabic = locale.isArabic;
        String t(String ar, String en) =>
            Formatters.t(ar, en, isArabic: isArabic);

        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.forestDeep,
                  Color(0xFF1A3A2C),
                  Color(0xFF24352C),
                ],
              ),
            ),
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(22),
                        child: BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            if (state is AuthError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    isArabic
                                        ? 'بيانات الدخول غير صحيحة'
                                        : state.message,
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            final loading = state is AuthLoading;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: 52,
                                    height: 52,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: AppColors.brass,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(
                                      'EG',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  'EG-Mobile ERP',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(fontWeight: FontWeight.w800),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  t(CompanyInfo.nameAr, CompanyInfo.nameEn),
                                  style: TextStyle(color: Colors.grey.shade700),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  t(CompanyInfo.plantAr, CompanyInfo.plantEn),
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 22),
                                TextField(
                                  controller: emailCtrl,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: t('البريد الإلكتروني', 'Email'),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                TextField(
                                  controller: passCtrl,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    labelText: t('كلمة المرور', 'Password'),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                FilledButton(
                                  onPressed: loading ? null : _submit,
                                  child: loading
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Text(t('تسجيل الدخول', 'Sign in')),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  t(
                                    'تجريبي: admin@egerman-upvc.com / admin123',
                                    'Demo: admin@egerman-upvc.com / admin123',
                                  ),
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                TextButton(
                                  onPressed: () =>
                                      context.read<LocaleCubit>().toggle(),
                                  child: Text(isArabic ? 'English' : 'العربية'),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
