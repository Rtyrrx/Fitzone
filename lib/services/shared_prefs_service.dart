import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  SharedPrefsService._();

  static final SharedPrefsService instance = SharedPrefsService._();

  static const String selectedTabKey = 'selectedTab';
  static const String lastCenterSearchKey = 'lastCenterSearchText';
  static const String lastViewedCenterIdKey = 'lastViewedCenterId';
  static const String themeModeKey = 'themeMode';
  static const String seedColorKey = 'seedColor';
  static const String activeUserIdKey = 'activeUserId';

  SharedPreferences? _prefs;
  String _activeUserId = 'local-user';

  Future<SharedPreferences> ensureInitialized() async {
    _prefs ??= await SharedPreferences.getInstance();
    final storedUserId = _prefs!.getString(activeUserIdKey);
    if (storedUserId != null && storedUserId.trim().isNotEmpty) {
      _activeUserId = storedUserId.trim();
    }
    return _prefs!;
  }

  SharedPreferences get prefs {
    final prefs = _prefs;
    if (prefs == null) {
      throw StateError('SharedPreferences has not been initialized.');
    }
    return prefs;
  }

  String get activeUserId => _activeUserId;

  Future<void> setActiveUserId(String? userId) async {
    final normalized = userId == null || userId.trim().isEmpty
        ? 'local-user'
        : userId.trim();
    _activeUserId = normalized;
    await prefs.setString(activeUserIdKey, normalized);
  }

  String userKey(String key, [String? userId]) {
    final owner = userId == null || userId.trim().isEmpty
        ? _activeUserId
        : userId.trim();
    return 'user.$owner.$key';
  }

  int get selectedTab {
    final tab = prefs.getInt(userKey(selectedTabKey)) ?? 0;
    if (tab < 0 || tab > 2) {
      return 0;
    }
    return tab;
  }

  Future<void> setSelectedTab(int index) async {
    await prefs.setInt(userKey(selectedTabKey), index);
  }

  String get lastCenterSearchText {
    return prefs.getString(userKey(lastCenterSearchKey)) ?? '';
  }

  Future<void> setLastCenterSearchText(String value) async {
    await prefs.setString(userKey(lastCenterSearchKey), value);
  }

  int? get lastViewedCenterId {
    return prefs.getInt(userKey(lastViewedCenterIdKey));
  }

  Future<void> setLastViewedCenterId(int centerId) async {
    await prefs.setInt(userKey(lastViewedCenterIdKey), centerId);
  }

  ThemeMode get themeMode {
    final value = prefs.getString(userKey(themeModeKey));
    if (value == ThemeMode.dark.name) {
      return ThemeMode.dark;
    }
    if (value == ThemeMode.system.name) {
      return ThemeMode.system;
    }
    return ThemeMode.light;
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await prefs.setString(userKey(themeModeKey), mode.name);
  }

  Color get seedColor {
    final value = prefs.getInt(userKey(seedColorKey));
    if (value == null) {
      return Colors.blue;
    }
    return Color(value);
  }

  Future<void> setSeedColor(Color color) async {
    await prefs.setInt(userKey(seedColorKey), color.toARGB32());
  }
}
