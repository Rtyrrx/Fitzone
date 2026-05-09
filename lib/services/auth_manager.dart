import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'shared_prefs_service.dart';

class AuthManager extends ChangeNotifier {
  static const String _loggedInKey = 'isLoggedIn';
  bool _isLoggedIn = false;
  StreamSubscription<User?>? _authSubscription;

  bool get isLoggedIn => _isLoggedIn;

  Future<void> init() async {
    final prefs = await SharedPrefsService.instance.ensureInitialized();
    _isLoggedIn = false;
    await _authSubscription?.cancel();
    if (Firebase.apps.isNotEmpty) {
      _isLoggedIn = FirebaseAuth.instance.currentUser != null;
      await prefs.setBool(_loggedInKey, _isLoggedIn);
      _authSubscription = FirebaseAuth.instance.authStateChanges().listen((
        user,
      ) async {
        _isLoggedIn = user != null;
        await SharedPrefsService.instance.prefs.setBool(_loggedInKey, _isLoggedIn);
        notifyListeners();
      });
    } else {
      await prefs.setBool(_loggedInKey, false);
    }
    notifyListeners();
  }

  Future<void> signIn() async {
    if (Firebase.apps.isNotEmpty) {
      _isLoggedIn = FirebaseAuth.instance.currentUser != null;
      await SharedPrefsService.instance.prefs.setBool(_loggedInKey, _isLoggedIn);
      notifyListeners();
      return;
    }
    final prefs = SharedPrefsService.instance.prefs;
    await prefs.setBool(_loggedInKey, true);
    _isLoggedIn = true;
    notifyListeners();
  }

  Future<void> signOut() async {
    if (Firebase.apps.isNotEmpty) {
      await FirebaseAuth.instance.signOut();
      return;
    }
    final prefs = SharedPrefsService.instance.prefs;
    await prefs.setBool(_loggedInKey, false);
    _isLoggedIn = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}
