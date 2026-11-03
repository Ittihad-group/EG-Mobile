import 'package:flutter_test/flutter_test.dart';
import 'package:eg_mobile/main.dart';

void main() {
  testWidgets('Login screen loads', (tester) async {
    await tester.pumpWidget(const EgMobileApp());
    expect(find.text('EG-Mobile ERP'), findsOneWidget);
    expect(find.textContaining('admin@egerman-upvc.com'), findsWidgets);
  });
}
