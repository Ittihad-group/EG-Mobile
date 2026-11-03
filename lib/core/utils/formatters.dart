class Formatters {
  const Formatters._();

  static String t(String ar, String en, {required bool isArabic}) =>
      isArabic ? ar : en;

  static String money(num value, {required bool isArabic}) {
    final n = value.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
        );
    return isArabic ? '$n ج.م' : 'EGP $n';
  }

  static String statusLabel(String code, {required bool isArabic}) {
    const map = {
      'draft': ('مسودة', 'Draft'),
      'confirmed': ('مؤكد', 'Confirmed'),
      'production': ('إنتاج', 'Production'),
      'shipped': ('تم الشحن', 'Shipped'),
      'queued': ('في الانتظار', 'Queued'),
      'in_progress': ('جارٍ', 'In progress'),
      'done': ('مكتمل', 'Done'),
      'dealer': ('موزع', 'Dealer'),
      'contractor': ('مقاول', 'Contractor'),
      'retail': ('تجزئة', 'Retail'),
    };
    final pair = map[code];
    if (pair == null) return code;
    return t(pair.$1, pair.$2, isArabic: isArabic);
  }
}
