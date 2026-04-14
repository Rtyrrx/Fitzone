import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesManager extends ChangeNotifier {
  static const String _favoriteCentersKey = 'favoriteCenters';
  static const String _notificationsEnabledKey = 'notificationsEnabled';
  static const String _languageKey = 'language';
  static const String _weeklyGoalKey = 'weeklyGoal';
  static const String _profileNameKey = 'profileName';
  static const String _profileEmailKey = 'profileEmail';
  static const String _profileImageUrlKey = 'profileImageUrl';
  static const String _paymentMethodKey = 'paymentMethod';

  Set<String> _favoriteCenters = <String>{};
  bool _notificationsEnabled = true;
  String _language = 'English';
  int _weeklyGoal = 4;
  String _profileName = 'Madias Bek';
  String _profileEmail = 'madias.bek@email.com';
  String _profileImageUrl = 'images/906a3198743a04accdc38e6a83a4d68b.jpg';
  String _paymentMethod = 'Visa ending in 4242';

  Set<String> get favoriteCenters => Set.unmodifiable(_favoriteCenters);
  int get favoriteCount => _favoriteCenters.length;
  bool get notificationsEnabled => _notificationsEnabled;
  String get language => _language;
  int get weeklyGoal => _weeklyGoal;
  String get profileName => _profileName;
  String get profileEmail => _profileEmail;
  String get profileImageUrl => _profileImageUrl;
  String get paymentMethod => _paymentMethod;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _favoriteCenters = prefs.getStringList(_favoriteCentersKey)?.toSet() ?? {};
    _notificationsEnabled = prefs.getBool(_notificationsEnabledKey) ?? true;
    _language = prefs.getString(_languageKey) ?? 'English';
    _weeklyGoal = prefs.getInt(_weeklyGoalKey) ?? 4;
    _profileName = prefs.getString(_profileNameKey) ?? 'Madias Bek';
    _profileEmail = prefs.getString(_profileEmailKey) ?? 'madias.bek@email.com';
    final storedProfileImage = prefs.getString(_profileImageUrlKey);
    if (storedProfileImage == null || storedProfileImage.startsWith('http')) {
      _profileImageUrl = 'images/906a3198743a04accdc38e6a83a4d68b.jpg';
      await prefs.setString(_profileImageUrlKey, _profileImageUrl);
    } else {
      _profileImageUrl = storedProfileImage;
    }
    _paymentMethod =
        prefs.getString(_paymentMethodKey) ?? 'Visa ending in 4242';
    notifyListeners();
  }

  bool isFavorite(String centerName) {
    return _favoriteCenters.contains(centerName);
  }

  Future<void> toggleFavorite(String centerName) async {
    if (_favoriteCenters.contains(centerName)) {
      _favoriteCenters.remove(centerName);
    } else {
      _favoriteCenters.add(centerName);
    }
    notifyListeners();
    await _saveFavoriteCenters();
  }

  Future<void> setNotificationsEnabled(bool value) async {
    _notificationsEnabled = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationsEnabledKey, value);
  }

  Future<void> setLanguage(String value) async {
    _language = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, value);
  }

  Future<void> setWeeklyGoal(int value) async {
    _weeklyGoal = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_weeklyGoalKey, value);
  }

  Future<void> updateProfile({
    required String name,
    required String email,
    String? imageUrl,
  }) async {
    _profileName = name;
    _profileEmail = email;
    if (imageUrl != null) {
      _profileImageUrl = imageUrl;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_profileNameKey, name);
    await prefs.setString(_profileEmailKey, email);
    if (imageUrl != null) {
      await prefs.setString(_profileImageUrlKey, imageUrl);
    }
  }

  Future<void> setProfileImageUrl(String value) async {
    _profileImageUrl = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_profileImageUrlKey, value);
  }

  Future<void> setPaymentMethod(String value) async {
    _paymentMethod = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_paymentMethodKey, value);
  }

  Future<void> _saveFavoriteCenters() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favoriteCentersKey, _favoriteCenters.toList());
  }
}
