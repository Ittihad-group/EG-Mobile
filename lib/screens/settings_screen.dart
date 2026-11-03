import 'package:flutter/material.dart';
import '../data/seed.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  final AppState state;
  const SettingsScreen({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final s = state;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s.t('بيانات الشركة', 'Company info'), style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                const SizedBox(height: 10),
                Text(s.t(CompanyInfo.nameAr, CompanyInfo.nameEn)),
                Text(s.t(CompanyInfo.plantAr, CompanyInfo.plantEn)),
                Text('${s.t('الخط الساخن', 'Hotline')}: ${CompanyInfo.hotline}'),
                Text('${s.t('الهاتف', 'Phone')}: ${CompanyInfo.phone}'),
                Text('${s.t('البريد', 'Email')}: ${CompanyInfo.email}'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            title: Text(s.t('اللغة', 'Language')),
            subtitle: Text(s.isArabic ? 'العربية' : 'English'),
            trailing: FilledButton(
              style: FilledButton.styleFrom(backgroundColor: AppTheme.forest),
              onPressed: s.toggleLang,
              child: Text(s.isArabic ? 'EN' : 'عربي'),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            title: Text(s.t('مرتبط بـ', 'Linked to')),
            subtitle: const Text('EG-System (Web ERP) · Ittihad-group'),
          ),
        ),
      ],
    );
  }
}
