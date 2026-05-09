import 'package:chapter3/data/database/app_database.dart';
import 'package:chapter3/main.dart';
import 'package:chapter3/providers/app_providers.dart';
import 'package:chapter3/services/shared_prefs_service.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../test/helpers/mock_services.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('user can log in, book a membership, and see it in bookings', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    await SharedPrefsService.instance.ensureInitialized();
    await SharedPrefsService.instance.prefs.clear();

    final database = AppDatabase.forTesting(NativeDatabase.memory());

    addTearDown(() async {
      await database.close();
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(database),
          seedServiceProvider.overrideWithValue(FakeMockFitnessService()),
        ],
        child: const FitZoneApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('FitZone'), findsWidgets);
    expect(find.text('Login'), findsOneWidget);

    await tester.enterText(
      find.byKey(const Key('login_email_field')),
      'student@fitzone.test',
    );
    await tester.enterText(
      find.byKey(const Key('login_password_field')),
      'securePass123',
    );
    await tester.tap(find.byKey(const Key('login_button')));
    await tester.pumpAndSettle();

    expect(find.text('Smart Discovery'), findsOneWidget);
    expect(find.text('FitZone Test Hub'), findsOneWidget);

    await tester.tap(find.text('FitZone Test Hub'));
    await tester.pumpAndSettle();

    expect(find.text('Available Programs'), findsOneWidget);
    expect(find.text('Monthly Pro'), findsWidgets);

    await tester.tap(find.text('Monthly Pro').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add to Booking'));
    await tester.pumpAndSettle();

    expect(find.text('1 Sessions Selected'), findsOneWidget);

    await tester.tap(find.text('1 Sessions Selected'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, 'Integration Tester');
    await tester.tap(find.textContaining('Submit Booking'));
    await tester.pumpAndSettle();

    expect(find.text('My Bookings'), findsOneWidget);
    expect(find.text('Member: Integration Tester'), findsOneWidget);
    expect(find.text('Monthly Pro x1'), findsOneWidget);
  });
}
