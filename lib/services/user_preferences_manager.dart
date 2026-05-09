import 'package:flutter/foundation.dart';

import 'shared_prefs_service.dart';

class UserPreferencesManager extends ChangeNotifier {
  static const String _favoriteCentersKey = 'favoriteCenters';
  static const String _notificationsEnabledKey = 'notificationsEnabled';
  static const String _languageKey = 'language';
  static const String _weeklyGoalKey = 'weeklyGoal';
  static const String _profileNameKey = 'profileName';
  static const String _profileEmailKey = 'profileEmail';
  static const String _profileImageUrlKey = 'profileImageUrl';
  static const String _paymentMethodKey = 'paymentMethod';
  static const String _needsProfileNameKey = 'needsProfileName';

  Set<String> _favoriteCenters = <String>{};
  bool _notificationsEnabled = true;
  String _language = 'English';
  int _weeklyGoal = 4;
  String _profileName = '';
  String _profileEmail = '';
  String _profileImageUrl = 'images/906a3198743a04accdc38e6a83a4d68b.jpg';
  String _paymentMethod = 'Visa ending in 4242';
  bool _needsProfileName = false;
  String _currentUserId = 'local-user';

  Set<String> get favoriteCenters => Set.unmodifiable(_favoriteCenters);
  int get favoriteCount => _favoriteCenters.length;
  bool get notificationsEnabled => _notificationsEnabled;
  String get language => _language;
  int get weeklyGoal => _weeklyGoal;
  String get profileName => _profileName;
  String get profileEmail => _profileEmail;
  String get profileImageUrl => _profileImageUrl;
  String get paymentMethod => _paymentMethod;
  bool get needsProfileName => _needsProfileName;

  Future<void> init() async {
    await SharedPrefsService.instance.ensureInitialized();
    _currentUserId = SharedPrefsService.instance.activeUserId;
    await _loadForCurrentUser();
  }

  Future<void> switchUser(String? userId, {String? email}) async {
    await SharedPrefsService.instance.setActiveUserId(userId);
    _currentUserId = SharedPrefsService.instance.activeUserId;
    await _loadForCurrentUser(defaultEmail: email);
  }

  Future<void> _loadForCurrentUser({String? defaultEmail}) async {
    final prefs = SharedPrefsService.instance.prefs;
    _favoriteCenters =
        prefs.getStringList(_key(_favoriteCentersKey))?.toSet() ?? {};
    _notificationsEnabled =
        prefs.getBool(_key(_notificationsEnabledKey)) ?? true;
    _language = prefs.getString(_key(_languageKey)) ?? 'English';
    _weeklyGoal = prefs.getInt(_key(_weeklyGoalKey)) ?? 4;
    _profileName = prefs.getString(_key(_profileNameKey)) ?? '';
    _profileEmail =
        prefs.getString(_key(_profileEmailKey)) ?? defaultEmail?.trim() ?? '';
    _needsProfileName = prefs.getBool(_key(_needsProfileNameKey)) ?? false;
    final storedProfileImage = prefs.getString(_key(_profileImageUrlKey));
    if (storedProfileImage == null || storedProfileImage.startsWith('http')) {
      _profileImageUrl = 'images/906a3198743a04accdc38e6a83a4d68b.jpg';
      await prefs.setString(_key(_profileImageUrlKey), _profileImageUrl);
    } else {
      _profileImageUrl = storedProfileImage;
    }
    _paymentMethod =
        prefs.getString(_key(_paymentMethodKey)) ?? 'Visa ending in 4242';
    if (defaultEmail != null &&
        defaultEmail.trim().isNotEmpty &&
        _profileEmail.isEmpty) {
      _profileEmail = defaultEmail.trim();
      await prefs.setString(_key(_profileEmailKey), _profileEmail);
    }
    notifyListeners();
  }

  String _key(String key) {
    return SharedPrefsService.instance.userKey(key, _currentUserId);
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
    final prefs = SharedPrefsService.instance.prefs;
    await prefs.setBool(_key(_notificationsEnabledKey), value);
  }

  Future<void> setLanguage(String value) async {
    _language = value;
    notifyListeners();
    final prefs = SharedPrefsService.instance.prefs;
    await prefs.setString(_key(_languageKey), value);
  }

  Future<void> setWeeklyGoal(int value) async {
    _weeklyGoal = value;
    notifyListeners();
    final prefs = SharedPrefsService.instance.prefs;
    await prefs.setInt(_key(_weeklyGoalKey), value);
  }

  Future<void> updateProfile({
    required String name,
    required String email,
    String? imageUrl,
    bool profileNameCompleted = false,
  }) async {
    _profileName = name;
    _profileEmail = email;
    if (profileNameCompleted && name.trim().isNotEmpty) {
      _needsProfileName = false;
    }
    if (imageUrl != null) {
      _profileImageUrl = imageUrl;
    }
    notifyListeners();
    final prefs = SharedPrefsService.instance.prefs;
    await prefs.setString(_key(_profileNameKey), name);
    await prefs.setString(_key(_profileEmailKey), email);
    await prefs.setBool(_key(_needsProfileNameKey), _needsProfileName);
    if (imageUrl != null) {
      await prefs.setString(_key(_profileImageUrlKey), imageUrl);
    }
  }

  Future<void> prepareNewUserProfile(String userId, String email) async {
    await SharedPrefsService.instance.setActiveUserId(userId);
    _currentUserId = SharedPrefsService.instance.activeUserId;
    _profileName = '';
    _profileEmail = email.trim();
    _needsProfileName = true;
    notifyListeners();
    final prefs = SharedPrefsService.instance.prefs;
    await prefs.setString(_key(_profileNameKey), _profileName);
    await prefs.setString(_key(_profileEmailKey), _profileEmail);
    await prefs.setBool(_key(_needsProfileNameKey), _needsProfileName);
  }

  Future<void> syncAuthEmail(String userId, String email) async {
    await switchUser(userId, email: email);
    final trimmed = email.trim();
    if (trimmed.isEmpty || trimmed == _profileEmail) {
      return;
    }
    _profileEmail = trimmed;
    notifyListeners();
    final prefs = SharedPrefsService.instance.prefs;
    await prefs.setString(_key(_profileEmailKey), _profileEmail);
  }

  Future<void> setProfileImageUrl(String value) async {
    _profileImageUrl = value;
    notifyListeners();
    final prefs = SharedPrefsService.instance.prefs;
    await prefs.setString(_key(_profileImageUrlKey), value);
  }

  Future<void> setPaymentMethod(String value) async {
    _paymentMethod = value;
    notifyListeners();
    final prefs = SharedPrefsService.instance.prefs;
    await prefs.setString(_key(_paymentMethodKey), value);
  }

  Future<void> _saveFavoriteCenters() async {
    final prefs = SharedPrefsService.instance.prefs;
    await prefs.setStringList(
      _key(_favoriteCentersKey),
      _favoriteCenters.toList(),
    );
  }
}
