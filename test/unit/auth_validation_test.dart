import 'package:chapter3/services/auth_validation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthValidation', () {
    test('empty email returns error', () {
      expect(AuthValidation.validateEmail(''), 'Email cannot be empty.');
    });

    test('empty password returns error', () {
      expect(
        AuthValidation.validatePassword(''),
        'Password cannot be empty.',
      );
    });

    test('invalid email returns error', () {
      expect(
        AuthValidation.validateEmail('not-an-email'),
        'Please enter a valid email address.',
      );
    });

    test('valid email and password pass validation', () {
      expect(
        AuthValidation.validateEmail('student@fitzone.test'),
        isNull,
      );
      expect(AuthValidation.validatePassword('securePass123'), isNull);
      expect(
        AuthValidation.isValidCredentials(
          'student@fitzone.test',
          'securePass123',
        ),
        isTrue,
      );
    });
  });
}
