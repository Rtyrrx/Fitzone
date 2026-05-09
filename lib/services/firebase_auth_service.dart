import 'package:firebase_auth/firebase_auth.dart';

import 'auth_validation.dart';

class FirebaseAuthService {
  FirebaseAuthService(this._auth);

  final FirebaseAuth _auth;

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  bool isLoggedIn() => _auth.currentUser != null;

  String? currentUserId() => _auth.currentUser?.uid;

  String? currentUserEmail() => _auth.currentUser?.email;

  Future<void> signup(String email, String password) async {
    AuthValidation.validateCredentialsOrThrow(email, password);
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      throw Exception(_mapException(error));
    }
  }

  Future<void> login(String email, String password) async {
    AuthValidation.validateCredentialsOrThrow(email, password);
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      throw Exception(_mapException(error));
    }
  }

  Future<void> logout() => _auth.signOut();

  String _mapException(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'weak-password':
        return 'Password is too weak.';
      case 'email-already-in-use':
        return 'This email is already in use.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Invalid email or password.';
      default:
        return error.message ?? 'Authentication failed.';
    }
  }
}
