import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _boxName = 'settings_cache';
  static const String _themeKey = 'is_dark_mode';

  static bool globalIsDarkMode = false;

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final box = await Hive.openBox(_boxName);
    _isDarkMode = box.get(_themeKey, defaultValue: false);
    globalIsDarkMode = _isDarkMode;
    notifyListeners();
  }

  Future<void> toggleTheme(bool isDark) async {
    _isDarkMode = isDark;
    globalIsDarkMode = isDark;
    notifyListeners();

    final box = await Hive.openBox(_boxName);
    await box.put(_themeKey, _isDarkMode);
  }
}
