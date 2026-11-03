import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/formatters.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../auth/presentation/cubit/auth_state.dart';
import '../../../customers/presentation/pages/customers_page.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';
import '../../../finance/presentation/pages/finance_page.dart';
import '../../../inventory/presentation/pages/inventory_page.dart';
import '../../../locale/presentation/cubit/locale_cubit.dart';
import '../../../locale/presentation/cubit/locale_state.dart';
import '../../../production/presentation/pages/production_page.dart';
import '../../../products/presentation/pages/products_page.dart';
import '../../../sales/presentation/pages/sales_page.dart';
import '../../../settings/presentation/pages/settings_page.dart';

class ShellPage extends StatefulWidget {
  const ShellPage({super.key});

  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, locale) {
        final isArabic = locale.isArabic;
        String t(String ar, String en) =>
            Formatters.t(ar, en, isArabic: isArabic);

        const pages = [
          DashboardPage(),
          ProductsPage(),
          InventoryPage(),
          SalesPage(),
          ProductionPage(),
          CustomersPage(),
          FinancePage(),
          SettingsPage(),
        ];

        final destinations = [
          NavigationDestination(
            icon: const Icon(Icons.dashboard_outlined),
            label: t('الرئيسية', 'Home'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.inventory_2_outlined),
            label: t('منتجات', 'Products'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.warehouse_outlined),
            label: t('مخزون', 'Stock'),
          ),
          NavigationDestination(
            icon: const Icon(Icons.point_of_sale_outlined),
            label: t('مبيعات', 'Sales'),
          ),
        ];

        final auth = context.watch<AuthCubit>().state;
        final user = auth is AuthAuthenticated ? auth.user : null;

        return Scaffold(
          appBar: AppBar(
            title: Text(t('EG-System موبايل', 'EG-System Mobile')),
            actions: [
              IconButton(
                tooltip: t('اللغة', 'Language'),
                onPressed: () => context.read<LocaleCubit>().toggle(),
                icon: const Icon(Icons.language),
              ),
              IconButton(
                tooltip: t('تسجيل الخروج', 'Logout'),
                onPressed: () => context.read<AuthCubit>().logout(),
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          drawer: Drawer(
            child: SafeArea(
              child: ListView(
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(color: AppColors.forestDeep),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'EG',
                          style: TextStyle(
                            color: AppColors.brassLight,
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          user == null ? '' : t(user.nameAr, user.nameEn),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          user?.email ?? '',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _drawerItem(0, Icons.dashboard_outlined, t('لوحة التحكم', 'Dashboard')),
                  _drawerItem(1, Icons.inventory_2_outlined, t('المنتجات', 'Products')),
                  _drawerItem(2, Icons.warehouse_outlined, t('المخزون', 'Inventory')),
                  _drawerItem(3, Icons.point_of_sale_outlined, t('المبيعات', 'Sales')),
                  _drawerItem(
                    4,
                    Icons.precision_manufacturing_outlined,
                    t('الإنتاج', 'Production'),
                  ),
                  _drawerItem(5, Icons.people_outline, t('العملاء', 'Customers')),
                  _drawerItem(
                    6,
                    Icons.account_balance_wallet_outlined,
                    t('المالية', 'Finance'),
                  ),
                  _drawerItem(7, Icons.settings_outlined, t('الإعدادات', 'Settings')),
                ],
              ),
            ),
          ),
          body: pages[index],
          bottomNavigationBar: NavigationBar(
            selectedIndex: index > 3 ? 0 : index,
            onDestinationSelected: (i) => setState(() => index = i),
            destinations: destinations,
          ),
        );
      },
    );
  }

  Widget _drawerItem(int i, IconData icon, String label) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      selected: index == i,
      onTap: () {
        setState(() => index = i);
        Navigator.pop(context);
      },
    );
  }
}
