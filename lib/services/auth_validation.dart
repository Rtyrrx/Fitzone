class AuthValidation {
  AuthValidation._();

  static final RegExp _emailPattern = RegExp(
    r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
  );

  static String? validateEmail(String? email) {
    final value = email?.trim() ?? '';
    if (value.isEmpty) {
      return 'Email cannot be empty.';
    }
    if (!_emailPattern.hasMatch(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    final value = password ?? '';
    if (value.isEmpty) {
      return 'Password cannot be empty.';
    }
    return null;
  }

  static bool isValidCredentials(String email, String password) {
    return validateEmail(email) == null && validatePassword(password) == null;
  }

  static void validateCredentialsOrThrow(String email, String password) {
    final emailError = validateEmail(email);
    if (emailError != null) {
      throw Exception(emailError);
    }

    final passwordError = validatePassword(password);
    if (passwordError != null) {
      throw Exception(passwordError);
    }
  }
}
