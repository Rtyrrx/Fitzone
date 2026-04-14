import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:chapter3/main.dart';

void main() {
  testWidgets('FitZone app loads correctly', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const FitZoneApp());
    await tester.pump(const Duration(milliseconds: 600));

    expect(find.text('FitZone'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });
}
