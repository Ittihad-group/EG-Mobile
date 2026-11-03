import 'package:flutter/foundation.dart';
import '../data/seed.dart';

class AppState extends ChangeNotifier {
  bool isArabic = true;
  AppUser? user;

  bool get isLoggedIn => user != null;

  String t(String ar, String en) => isArabic ? ar : en;

  void toggleLang() {
    isArabic = !isArabic;
    notifyListeners();
  }

  bool login(String email, String password) {
    for (final u in users) {
      if (u.email == email.trim() && u.password == password) {
        user = u;
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  void logout() {
    user = null;
    notifyListeners();
  }

  String money(num value) {
    final n = value.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
        );
    return isArabic ? '$n ج.م' : 'EGP $n';
  }

  String statusLabel(String code) {
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
    return t(pair.$1, pair.$2);
  }
}
