import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/common/theme/application_theme.dart';
import 'package:jukebox_music_player/src/common/util/preferences_dao.dart';

/// {@template theme_datasource}
/// [ThemeDataSource] is an entry point to the theme data layer.
///
/// This is used to set and get the current theme.
/// {@endtemplate}
abstract interface class ThemeDataSource {
  /// Set theme
  Future<void> setTheme(ApplicationTheme theme);

  /// Get current theme from cache
  ApplicationTheme? loadThemeFromCache();
}

/// {@macro theme_datasource}
final class ThemeDataSourceImpl extends PreferencesDao
    implements ThemeDataSource {
  /// {@macro theme_datasource}
  const ThemeDataSourceImpl({
    required super.sharedPreferences,
    required this.codec,
  });

  /// Codec for [ThemeMode]
  final Codec<ThemeMode, String> codec;

  PreferencesEntry<int> get _seedColor => intEntry('theme.seed_color');

  PreferencesEntry<String> get _themeMode => stringEntry('theme.mode');

  @override
  Future<void> setTheme(ApplicationTheme theme) async {
    await _seedColor.setIfNullRemove(theme.seed.value);
    await _themeMode.setIfNullRemove(codec.encode(theme.mode));
  }

  @override
  ApplicationTheme? loadThemeFromCache() {
    final seedColor = _seedColor.read();
    final type = _themeMode.read();
    if (type == null || seedColor == null) return null;
    return ApplicationTheme(seed: Color(seedColor), mode: codec.decode(type));
  }
}
