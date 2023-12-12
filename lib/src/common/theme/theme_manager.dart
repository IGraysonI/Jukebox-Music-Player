import 'package:flutter/material.dart';

import 'package:jukebox_music_player/src/common/cache/shared_prefs_store.dart';
import 'package:jukebox_music_player/src/common/cache/shared_prefs_keys.dart';

class ThemeManager with ChangeNotifier {
  ThemeManager({required SharedPrefsStore sharedPrefsStore})
      : _sharedPrefsStore = sharedPrefsStore,
        _themeMode = _getThemeModeFromCacheOrSystem(sharedPrefsStore);

  static ThemeMode _getThemeModeFromCacheOrSystem(
    SharedPrefsStore sharedPrefsStore,
  ) =>
      sharedPrefsStore.read(SharedPrefsKeys.themeMode) != null
          ? sharedPrefsStore.read(SharedPrefsKeys.themeMode)!
          : ThemeMode.system;

  final SharedPrefsStore _sharedPrefsStore;
  ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;
  bool get isLightTheme => _themeMode == ThemeMode.light;
  bool get isDarkTheme => _themeMode == ThemeMode.dark;

  Future<void> toogleTheme({required ThemeMode themeMode}) async =>
      _sharedPrefsStore.write(SharedPrefsKeys.themeMode, themeMode).then(
        (value) {
          _themeMode = themeMode;
          notifyListeners();
        },
      );
}
