import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:eg_mobile/app.dart';
import 'package:eg_mobile/core/di/injection_container.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await sl.reset();
    await initDependencies();
  });

  testWidgets('Login screen loads', (tester) async {
    await tester.pumpWidget(const EgMobileApp());
    await tester.pumpAndSettle();

    expect(find.text('EG-Mobile ERP'), findsOneWidget);
    expect(find.textContaining('admin@egerman-upvc.com'), findsWidgets);
  });
}
