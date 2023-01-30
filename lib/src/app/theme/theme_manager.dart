import 'package:flutter/material.dart';

import '../../common/cache/shared_prefs_store.dart';
import '../../core/cache/shared_prefs_keys.dart';

class ThemeManager with ChangeNotifier {
  ThemeManager({required SharedPrefsStore sharedPrefsStore})
      : _sharedPrefsStore = sharedPrefsStore,
        _themeMode = _getThemeMode(sharedPrefsStore);

  static ThemeMode _getThemeMode(SharedPrefsStore sharedPrefsStore) {
    return sharedPrefsStore.read(SharedPrefsKeys.themeMode) != null
        ? sharedPrefsStore.read(SharedPrefsKeys.themeMode)!
        : ThemeMode.system;
  }

  final SharedPrefsStore _sharedPrefsStore;
  ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;
  bool get isLightTheme => _themeMode == ThemeMode.light;
  bool get isDarkTheme => _themeMode == ThemeMode.dark;

  Future<void> toogleTheme({required ThemeMode themeMode}) async {
    await _sharedPrefsStore.write(SharedPrefsKeys.themeMode, themeMode).then(
      (value) {
        _themeMode = themeMode;
        notifyListeners();
      },
    );
  }
}
