import 'dart:convert';

import 'package:flutter/material.dart';

/// {@template theme_mode_codec}
/// Codec for [ThemeMode]
/// {@endtemplate}
final class ThemeModeCodec extends Codec<ThemeMode, String> {
  /// {@macro theme_mode_codec}
  const ThemeModeCodec();

  @override
  Converter<String, ThemeMode> get decoder => const _ThemeModeDecoder();

  @override
  Converter<ThemeMode, String> get encoder => const _ThemeModeEncoder();
}

/// {@macro _theme_mode_decoder}
final class _ThemeModeDecoder extends Converter<String, ThemeMode> {
  /// {@macro _theme_mode_decoder}
  const _ThemeModeDecoder();

  @override
  ThemeMode convert(String input) => switch (input) {
        'ThemeMode.dark' => ThemeMode.dark,
        'ThemeMode.light' => ThemeMode.light,
        'ThemeMode.system' => ThemeMode.system,
        _ => throw ArgumentError.value(
            input,
            'input',
            'Cannot convert $input to $ThemeMode',
          ),
      };
}

/// {@macro _theme_mode_encoder}
final class _ThemeModeEncoder extends Converter<ThemeMode, String> {
  /// {@macro _theme_mode_encoder}
  const _ThemeModeEncoder();

  @override
  String convert(ThemeMode input) => switch (input) {
        ThemeMode.dark => 'ThemeMode.dark',
        ThemeMode.light => 'ThemeMode.light',
        ThemeMode.system => 'ThemeMode.system',
      };
}
