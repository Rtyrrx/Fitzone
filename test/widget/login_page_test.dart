import 'package:chapter3/providers/app_providers.dart';
import 'package:chapter3/screens/login_page.dart';
import 'package:chapter3/services/shared_prefs_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/mock_services.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SharedPrefsService.instance.ensureInitialized();
    await SharedPrefsService.instance.prefs.clear();
  });

  Widget buildPage() {
    return ProviderScope(
      overrides: [
        firebaseConfiguredProvider.overrideWith((ref) => false),
        firebaseAuthProvider.overrideWith((ref) => FakeAuthService()),
      ],
      child: const MaterialApp(home: LoginPage()),
    );
  }

  testWidgets('renders email field, password field, and login button', (
    tester,
  ) async {
    await tester.pumpWidget(buildPage());

    expect(find.byKey(const Key('login_email_field')), findsOneWidget);
    expect(find.byKey(const Key('login_password_field')), findsOneWidget);
    expect(find.byKey(const Key('login_button')), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('shows validation errors for empty input', (tester) async {
    await tester.pumpWidget(buildPage());

    await tester.ensureVisible(find.byKey(const Key('login_button')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('login_button')));
    await tester.pump();

    expect(find.text('Email cannot be empty.'), findsOneWidget);
    expect(find.text('Password cannot be empty.'), findsOneWidget);
  });
}
