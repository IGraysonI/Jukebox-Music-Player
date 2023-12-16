import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/common/theme/theme.dart';

/// {@template app_theme}
/// An immutable class that holds properties needed
/// to build a [ThemeData] for the app.
/// {@endtemplate}
@immutable
final class ApplicationTheme with Diagnosticable {
  /// {@macro app_theme}
  ApplicationTheme({
    required this.mode,
    required this.seed,
  })  : darkTheme = darkThemeData.copyWith(
          //TODO: Может быть не правильно
          colorScheme: ColorScheme.fromSeed(seedColor: seed),
        ),
        lightTheme = lightThemeData.copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: seed),
        );

  /// The type of theme to use.
  final ThemeMode mode;

  /// The seed color to generate the [ColorScheme] from.
  final Color seed;

  /// The dark [ThemeData] for this [ApplicationTheme].
  final ThemeData darkTheme;

  /// The light [ThemeData] for this [ApplicationTheme].
  final ThemeData lightTheme;

  /// The default [ApplicationTheme].
  static final defaultTheme = ApplicationTheme(
    mode: ThemeMode.system,
    seed: Colors.green[700]!,
  );

  /// The [ThemeData] for this [ApplicationTheme].
  /// This is computed based on the [mode].
  ThemeData computeTheme() => switch (mode) {
        ThemeMode.light => lightTheme,
        ThemeMode.dark => darkTheme,
        ThemeMode.system =>
          PlatformDispatcher.instance.platformBrightness == Brightness.dark
              ? darkTheme
              : lightTheme,
      };

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('seed', seed));
    properties.add(EnumProperty<ThemeMode>('type', mode));
    properties.add(DiagnosticsProperty<ThemeData>('lightTheme', lightTheme));
    properties.add(DiagnosticsProperty<ThemeData>('darkTheme', darkTheme));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApplicationTheme &&
          runtimeType == other.runtimeType &&
          seed == other.seed &&
          mode == other.mode;

  @override
  int get hashCode => mode.hashCode ^ seed.hashCode;
}
