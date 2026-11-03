class CompanyInfo {
  static const nameAr = 'المصرية الألمانية لتصنيع منتجات WPC & PVC';
  static const nameEn = 'Egyptian-German for WPC & PVC Products';
  static const shortAr = 'المصرية الألمانية';
  static const shortEn = 'Egyptian-German';
  static const plantAr = 'مصنع جمصة — المنطقة الصناعية المرحلة الثالثة';
  static const plantEn = 'Gamasa Plant — Industrial Zone Phase 3';
  static const hotline = '15536';
  static const phone = '+201555515536';
  static const email = 'contact@egerman-upvc.com';
}

class AppUser {
  final String id;
  final String nameAr;
  final String nameEn;
  final String email;
  final String password;
  final String role;

  const AppUser({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.email,
    required this.password,
    required this.role,
  });
}

const users = [
  AppUser(
    id: 'u1',
    nameAr: 'مدير النظام',
    nameEn: 'System Admin',
    email: 'admin@egerman-upvc.com',
    password: 'admin123',
    role: 'admin',
  ),
  AppUser(
    id: 'u2',
    nameAr: 'مدير المبيعات',
    nameEn: 'Sales Manager',
    email: 'sales@egerman-upvc.com',
    password: 'sales123',
    role: 'sales',
  ),
];

class Product {
  final String id;
  final String sku;
  final String nameAr;
  final String nameEn;
  final String categoryAr;
  final String categoryEn;
  final double price;
  final double cost;
  final int minStock;
  final List<int> widthsCm;
  final List<String> colors;

  const Product({
    required this.id,
    required this.sku,
    required this.nameAr,
    required this.nameEn,
    required this.categoryAr,
    required this.categoryEn,
    required this.price,
    required this.cost,
    required this.minStock,
    required this.widthsCm,
    required this.colors,
  });
}

const products = [
  Product(
    id: 'p-d134',
    sku: 'DOOR-D134',
    nameAr: 'باب WPC مودرن D134',
    nameEn: 'WPC Modern Door D134',
    categoryAr: 'أبواب WPC & PVC',
    categoryEn: 'WPC & PVC Doors',
    price: 7100,
    cost: 4800,
    minStock: 20,
    widthsCm: [80, 90, 100, 110],
    colors: ['C205', 'C091', 'C102', 'C115'],
  ),
  Product(
    id: 'p-d132',
    sku: 'DOOR-D132',
    nameAr: 'باب WPC مودرن D132',
    nameEn: 'WPC Modern Door D132',
    categoryAr: 'أبواب WPC & PVC',
    categoryEn: 'WPC & PVC Doors',
    price: 7100,
    cost: 4750,
    minStock: 20,
    widthsCm: [80, 90, 100, 110],
    colors: ['C205', 'C091', 'C8001'],
  ),
  Product(
    id: 'p-clad-16',
    sku: 'CLAD-16x280',
    nameAr: 'تجاليد بديل خشب 16×280 سم',
    nameEn: 'Wood-alt cladding 16×280 cm',
    categoryAr: 'تجاليد WPC',
    categoryEn: 'WPC Cladding',
    price: 250,
    cost: 140,
    minStock: 200,
    widthsCm: [16],
    colors: ['91', '102', '160', '205'],
  ),
  Product(
    id: 'p-foam-18',
    sku: 'FOAM-18',
    nameAr: 'لوح PVC فوم بورد 18 مم',
    nameEn: 'PVC Foam Board 18mm',
    categoryAr: 'فوم بورد',
    categoryEn: 'Foam Board',
    price: 420,
    cost: 260,
    minStock: 100,
    widthsCm: [],
    colors: ['White'],
  ),
  Product(
    id: 'p-acc-kit',
    sku: 'ACC-DOOR-KIT',
    nameAr: 'طقم إكسسوارات باب',
    nameEn: 'Door accessories kit',
    categoryAr: 'إكسسوارات',
    categoryEn: 'Accessories',
    price: 450,
    cost: 220,
    minStock: 50,
    widthsCm: [],
    colors: [],
  ),
];

class StockRow {
  final String id;
  final String productId;
  final String warehouseAr;
  final String warehouseEn;
  final int qty;
  final int reserved;

  const StockRow({
    required this.id,
    required this.productId,
    required this.warehouseAr,
    required this.warehouseEn,
    required this.qty,
    required this.reserved,
  });

  int get available => qty - reserved;
}

const inventory = [
  StockRow(
    id: 'inv1',
    productId: 'p-d134',
    warehouseAr: 'منتجات تامة — جمصة',
    warehouseEn: 'Finished Goods — Gamasa',
    qty: 86,
    reserved: 12,
  ),
  StockRow(
    id: 'inv2',
    productId: 'p-d132',
    warehouseAr: 'منتجات تامة — جمصة',
    warehouseEn: 'Finished Goods — Gamasa',
    qty: 54,
    reserved: 8,
  ),
  StockRow(
    id: 'inv3',
    productId: 'p-clad-16',
    warehouseAr: 'منتجات تامة — جمصة',
    warehouseEn: 'Finished Goods — Gamasa',
    qty: 1240,
    reserved: 180,
  ),
  StockRow(
    id: 'inv4',
    productId: 'p-foam-18',
    warehouseAr: 'منتجات تامة — جمصة',
    warehouseEn: 'Finished Goods — Gamasa',
    qty: 320,
    reserved: 40,
  ),
  StockRow(
    id: 'inv5',
    productId: 'p-acc-kit',
    warehouseAr: 'منتجات تامة — جمصة',
    warehouseEn: 'Finished Goods — Gamasa',
    qty: 210,
    reserved: 25,
  ),
];

class SalesOrder {
  final String id;
  final String number;
  final String customerAr;
  final String customerEn;
  final String date;
  final String status;
  final double total;

  const SalesOrder({
    required this.id,
    required this.number,
    required this.customerAr,
    required this.customerEn,
    required this.date,
    required this.status,
    required this.total,
  });
}

const salesOrders = [
  SalesOrder(
    id: 'so1',
    number: 'SO-2025-0142',
    customerAr: 'موزع معتمد — الدقهلية',
    customerEn: 'Authorized dealer — Dakahlia',
    date: '2025-10-28',
    status: 'confirmed',
    total: 90600,
  ),
  SalesOrder(
    id: 'so2',
    number: 'SO-2025-0143',
    customerAr: 'مقاول مشاريع سكنية',
    customerEn: 'Residential contractor',
    date: '2025-10-30',
    status: 'production',
    total: 116800,
  ),
  SalesOrder(
    id: 'so3',
    number: 'SO-2025-0144',
    customerAr: 'شركة العدس — عُمان',
    customerEn: 'Al-Adas Co. — Oman',
    date: '2025-11-01',
    status: 'shipped',
    total: 355000,
  ),
  SalesOrder(
    id: 'so4',
    number: 'SO-2025-0145',
    customerAr: 'عميل تجزئة — استلام مصنع',
    customerEn: 'Retail pickup — factory',
    date: '2025-11-02',
    status: 'draft',
    total: 14200,
  ),
];

class WorkOrder {
  final String id;
  final String number;
  final String productAr;
  final String productEn;
  final String lineAr;
  final String lineEn;
  final int qty;
  final int progress;
  final String status;
  final String dueDate;

  const WorkOrder({
    required this.id,
    required this.number,
    required this.productAr,
    required this.productEn,
    required this.lineAr,
    required this.lineEn,
    required this.qty,
    required this.progress,
    required this.status,
    required this.dueDate,
  });
}

const workOrders = [
  WorkOrder(
    id: 'wo1',
    number: 'WO-2025-0088',
    productAr: 'باب WPC مودرن D134',
    productEn: 'WPC Modern Door D134',
    lineAr: 'خط الأبواب 1',
    lineEn: 'Doors line 1',
    qty: 40,
    progress: 55,
    status: 'in_progress',
    dueDate: '2025-11-08',
  ),
  WorkOrder(
    id: 'wo2',
    number: 'WO-2025-0089',
    productAr: 'تجاليد 16×280',
    productEn: 'Cladding 16×280',
    lineAr: 'خط التجاليد',
    lineEn: 'Cladding line',
    qty: 500,
    progress: 0,
    status: 'queued',
    dueDate: '2025-11-06',
  ),
  WorkOrder(
    id: 'wo3',
    number: 'WO-2025-0087',
    productAr: 'باب WPC مودرن D132',
    productEn: 'WPC Modern Door D132',
    lineAr: 'خط الأبواب 2',
    lineEn: 'Doors line 2',
    qty: 30,
    progress: 100,
    status: 'done',
    dueDate: '2025-10-30',
  ),
];

class Customer {
  final String id;
  final String code;
  final String nameAr;
  final String nameEn;
  final String type;
  final String cityAr;
  final String cityEn;
  final double balance;
  final String phone;

  const Customer({
    required this.id,
    required this.code,
    required this.nameAr,
    required this.nameEn,
    required this.type,
    required this.cityAr,
    required this.cityEn,
    required this.balance,
    required this.phone,
  });
}

const customers = [
  Customer(
    id: 'c1',
    code: 'CUS-001',
    nameAr: 'شركة العدس — سلطنة عُمان',
    nameEn: 'Al-Adas Co. — Oman',
    type: 'dealer',
    cityAr: 'مسقط',
    cityEn: 'Muscat',
    balance: 185000,
    phone: '+96800000000',
  ),
  Customer(
    id: 'c2',
    code: 'CUS-002',
    nameAr: 'موزع معتمد — الدقهلية',
    nameEn: 'Authorized dealer — Dakahlia',
    type: 'dealer',
    cityAr: 'المنصورة',
    cityEn: 'Mansoura',
    balance: 42000,
    phone: '+201000000001',
  ),
  Customer(
    id: 'c3',
    code: 'CUS-003',
    nameAr: 'مقاول مشاريع سكنية',
    nameEn: 'Residential contractor',
    type: 'contractor',
    cityAr: 'القاهرة',
    cityEn: 'Cairo',
    balance: 96000,
    phone: '+201000000002',
  ),
];

class FinanceSummary {
  final double monthSales;
  final double receivables;
  final double payables;
  final double cash;

  const FinanceSummary({
    required this.monthSales,
    required this.receivables,
    required this.payables,
    required this.cash,
  });
}

const finance = FinanceSummary(
  monthSales: 528400,
  receivables: 323000,
  payables: 152700,
  cash: 410500,
);

Product? productById(String id) {
  for (final p in products) {
    if (p.id == id) return p;
  }
  return null;
}
