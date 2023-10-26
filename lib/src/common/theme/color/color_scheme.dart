import 'package:flutter/material.dart';

import '../../../common/utils/regex_validator.dart';

LightColorPallete _lightColorPallete = const LightColorPallete();

/// Возвращает [Color] из хешкода
Color _hexToColor(String colorCode) {
  assert(
    RegexValidator.color(colorCode),
    'Переданный colorCode не соответсвует hex-формату',
  );
  return Color(int.parse(colorCode.substring(1, 7), radix: 16) + 0xFF000000);
}

/// Light
final ColorScheme lightColorScheme = ColorScheme.light(
  background: _lightColorPallete.scaffoldBackgroundColor,
  primary: _lightColorPallete.primaryColor,
  secondary: _lightColorPallete.secondaryColor,
  onBackground: Colors.red,
);

/// Dark
//TODO: Добавить темную тему

abstract class ColorPallete {
  Color get scaffoldBackgroundColor;
  Color get primaryColor;
  Color get secondaryColor;
  Color get shadow;
  Color get inputFillColor;
}

//TODO: Добавить цвета темной темы

/// Цвета светлой темы
class LightColorPallete implements ColorPallete {
  const LightColorPallete();

  @override
  Color get scaffoldBackgroundColor => _hexToColor('#ffffff');

  @override
  Color get primaryColor => _hexToColor('#5b6879');

  @override
  Color get secondaryColor => _hexToColor('#95b0d3');

  @override
  Color get shadow => _hexToColor('#94b6df');

  @override
  Color get inputFillColor => _hexToColor('#82a7d4');
}

/// Colors
// #5b6879
// Midnight Shadow
// #95b0d3
// Mont Blanc
// #94b6df
// Adrift on the Nile
// #82a7d4
// Windfall
// #7ea0ca
// Shipmate
// #aab6c6
// Sailor Boy
