import 'package:flutter/material.dart' show Locale;
import 'package:jukebox_music_player/src/common/theme/application_theme.dart';
import 'package:jukebox_music_player/src/features/settings/data/locale_data_source.dart';
import 'package:jukebox_music_player/src/features/settings/data/theme_data_source.dart';

/// Settings repository
abstract interface class ISettingsRepository {
  /// Set theme
  Future<void> setTheme(ApplicationTheme theme);

  /// Set locale
  Future<void> setLocale(Locale locale);

  /// Observe theme mode changes
  ApplicationTheme? fetchThemeFromCache();

  /// Observe locale changes
  Locale? fetchLocaleFromCache();
}

/// {@template settings_repository_impl}
/// Settings repository implementation
/// {@endtemplate}
final class SettingsRepositoryImpl implements ISettingsRepository {
  /// {@macro settings_repository_impl}
  const SettingsRepositoryImpl({
    required ThemeDataSource themeDataSource,
    required LocaleDataSource localeDataSource,
  })  : _themeDataSource = themeDataSource,
        _localeDataSource = localeDataSource;

  final ThemeDataSource _themeDataSource;
  final LocaleDataSource _localeDataSource;

  @override
  Locale? fetchLocaleFromCache() => _localeDataSource.loadLocaleFromCache();

  @override
  ApplicationTheme? fetchThemeFromCache() => _themeDataSource.loadThemeFromCache();

  @override
  Future<void> setLocale(Locale locale) => _localeDataSource.setLocale(locale);

  @override
  Future<void> setTheme(ApplicationTheme theme) => _themeDataSource.setTheme(theme);
}
