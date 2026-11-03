import 'package:flutter/material.dart';
import '../state/app_state.dart';
import 'customers_screen.dart';
import 'dashboard_screen.dart';
import 'finance_screen.dart';
import 'inventory_screen.dart';
import 'production_screen.dart';
import 'products_screen.dart';
import 'sales_screen.dart';
import 'settings_screen.dart';

class ShellScreen extends StatefulWidget {
  final AppState state;
  const ShellScreen({super.key, required this.state});

  @override
  State<ShellScreen> createState() => _ShellScreenState();
}

class _ShellScreenState extends State<ShellScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final s = widget.state;
    final pages = [
      DashboardScreen(state: s),
      ProductsScreen(state: s),
      InventoryScreen(state: s),
      SalesScreen(state: s),
      ProductionScreen(state: s),
      CustomersScreen(state: s),
      FinanceScreen(state: s),
      SettingsScreen(state: s),
    ];

    final destinations = [
      NavigationDestination(icon: const Icon(Icons.dashboard_outlined), label: s.t('الرئيسية', 'Home')),
      NavigationDestination(icon: const Icon(Icons.inventory_2_outlined), label: s.t('منتجات', 'Products')),
      NavigationDestination(icon: const Icon(Icons.warehouse_outlined), label: s.t('مخزون', 'Stock')),
      NavigationDestination(icon: const Icon(Icons.point_of_sale_outlined), label: s.t('مبيعات', 'Sales')),
    ];

    // Extra modules via drawer; bottom nav keeps primary 4
    return Scaffold(
      appBar: AppBar(
        title: Text(s.t('EG-System موبايل', 'EG-System Mobile')),
        actions: [
          IconButton(
            tooltip: s.t('اللغة', 'Language'),
            onPressed: s.toggleLang,
            icon: const Icon(Icons.language),
          ),
          IconButton(
            tooltip: s.t('تسجيل الخروج', 'Logout'),
            onPressed: s.logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Color(0xFF0D2A1E)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('EG', style: TextStyle(color: Color(0xFFC9A66B), fontSize: 28, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 8),
                    Text(
                      s.user == null ? '' : s.t(s.user!.nameAr, s.user!.nameEn),
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      s.user?.email ?? '',
                      style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12),
                    ),
                  ],
                ),
              ),
              _drawerItem(0, Icons.dashboard_outlined, s.t('لوحة التحكم', 'Dashboard')),
              _drawerItem(1, Icons.inventory_2_outlined, s.t('المنتجات', 'Products')),
              _drawerItem(2, Icons.warehouse_outlined, s.t('المخزون', 'Inventory')),
              _drawerItem(3, Icons.point_of_sale_outlined, s.t('المبيعات', 'Sales')),
              _drawerItem(4, Icons.precision_manufacturing_outlined, s.t('الإنتاج', 'Production')),
              _drawerItem(5, Icons.people_outline, s.t('العملاء', 'Customers')),
              _drawerItem(6, Icons.account_balance_wallet_outlined, s.t('المالية', 'Finance')),
              _drawerItem(7, Icons.settings_outlined, s.t('الإعدادات', 'Settings')),
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
