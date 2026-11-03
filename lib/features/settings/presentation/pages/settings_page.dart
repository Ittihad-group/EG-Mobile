import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/company_info.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../../../locale/presentation/cubit/locale_cubit.dart';
import '../../../locale/presentation/cubit/locale_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, locale) {
        final isArabic = locale.isArabic;
        String t(String ar, String en) =>
            Formatters.t(ar, en, isArabic: isArabic);

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t('بيانات الشركة', 'Company info'),
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(t(CompanyInfo.nameAr, CompanyInfo.nameEn)),
                    Text(t(CompanyInfo.plantAr, CompanyInfo.plantEn)),
                    Text('${t('الخط الساخن', 'Hotline')}: ${CompanyInfo.hotline}'),
                    Text('${t('الهاتف', 'Phone')}: ${CompanyInfo.phone}'),
                    Text('${t('البريد', 'Email')}: ${CompanyInfo.email}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                title: Text(t('اللغة', 'Language')),
                subtitle: Text(isArabic ? 'العربية' : 'English'),
                trailing: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.forest,
                  ),
                  onPressed: () => context.read<LocaleCubit>().toggle(),
                  child: Text(isArabic ? 'EN' : 'عربي'),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                title: Text(t('مرتبط بـ', 'Linked to')),
                subtitle: const Text('EG-System (Web ERP) · Ittihad-group'),
              ),
            ),
          ],
        );
      },
    );
  }
}
