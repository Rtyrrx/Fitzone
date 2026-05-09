import 'package:chapter3/providers/app_providers.dart';
import 'package:chapter3/screens/login_page.dart';
import 'package:chapter3/services/shared_prefs_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/mock_services.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SharedPrefsService.instance.ensureInitialized();
    await SharedPrefsService.instance.prefs.clear();
  });

  testGoldens('login page matches golden', (tester) async {
    await tester.pumpWidgetBuilder(
      ProviderScope(
        overrides: [
          firebaseConfiguredProvider.overrideWith((ref) => false),
          firebaseAuthProvider.overrideWith((ref) => FakeAuthService()),
        ],
        child: const MaterialApp(home: LoginPage()),
      ),
      surfaceSize: const Size(430, 932),
    );

    await screenMatchesGolden(tester, 'login_page');
  });
}
