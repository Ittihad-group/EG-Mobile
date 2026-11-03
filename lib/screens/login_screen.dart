import 'package:flutter/material.dart';
import '../data/seed.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';

class LoginScreen extends StatefulWidget {
  final AppState state;
  const LoginScreen({super.key, required this.state});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController(text: 'admin@egerman-upvc.com');
  final passCtrl = TextEditingController(text: 'admin123');
  String? error;

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final ok = widget.state.login(emailCtrl.text, passCtrl.text);
    if (!ok) {
      setState(() {
        error = widget.state.t('بيانات الدخول غير صحيحة', 'Invalid credentials');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.state;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppTheme.forestDeep, Color(0xFF1A3A2C), Color(0xFF24352C)],
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: 52,
                            height: 52,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppTheme.brass,
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
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          s.t(CompanyInfo.nameAr, CompanyInfo.nameEn),
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          s.t(CompanyInfo.plantAr, CompanyInfo.plantEn),
                          style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                        ),
                        const SizedBox(height: 22),
                        TextField(
                          controller: emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: s.t('البريد الإلكتروني', 'Email'),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: passCtrl,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: s.t('كلمة المرور', 'Password'),
                          ),
                        ),
                        if (error != null) ...[
                          const SizedBox(height: 10),
                          Text(error!, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
                        ],
                        const SizedBox(height: 18),
                        FilledButton(
                          onPressed: _submit,
                          child: Text(s.t('تسجيل الدخول', 'Sign in')),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          s.t(
                            'تجريبي: admin@egerman-upvc.com / admin123',
                            'Demo: admin@egerman-upvc.com / admin123',
                          ),
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                        TextButton(
                          onPressed: s.toggleLang,
                          child: Text(s.isArabic ? 'English' : 'العربية'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
