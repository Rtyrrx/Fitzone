import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/native.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:chapter3/main.dart';
import 'package:chapter3/data/database/app_database.dart';
import 'package:chapter3/providers/app_providers.dart';
import 'package:chapter3/services/shared_prefs_service.dart';

import 'helpers/mock_services.dart';

void main() {
  testWidgets('FitZone app loads correctly', (WidgetTester tester) async {
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

    expect(find.text('FitZone'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}
