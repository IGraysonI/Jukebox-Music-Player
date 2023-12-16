import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/common/theme/application_theme.dart';

/// {@template theme_scope_controller}
/// A controller that holds and operates the app theme
/// {@endtemplate}
abstract interface class IThemeScopeController {
  /// Get the current []
  ApplicationTheme get theme;

  /// Set theme to [theme]
  void setThemeMode(ThemeMode theme);

  /// Set the theme seed color to [color]
  void setThemeSeedColor(Color color);
}
