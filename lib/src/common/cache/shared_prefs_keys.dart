import 'package:flutter/material.dart';

import 'package:jukebox_music_player/src/common/cache/type_store_key.dart';

/// Типизированные ключи для хранилища
class SharedPrefsKeys {
  const SharedPrefsKeys._();

  /// Тема приложения
  static TypeStoreKey<ThemeMode> get themeMode =>
      TypeStoreKey<ThemeMode>('themeMode');
}
