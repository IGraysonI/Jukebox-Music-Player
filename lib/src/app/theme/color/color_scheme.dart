import 'package:flutter/material.dart';

import '../../../common/utils/regex_validator.dart';

LightColorPallete lightColorPallete = LightColorPallete();

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
  background: lightColorPallete.scaffoldBackgroundColor,
  primary: lightColorPallete.primaryColor,
  secondary: lightColorPallete.secondaryColor,
);

/// Dark

abstract class ColorPallete {
  Color get scaffoldBackgroundColor;
  Color get primaryColor;
  Color get secondaryColor;
}

/// Цвета светлой темы
class LightColorPallete implements ColorPallete {
  @override
  Color get scaffoldBackgroundColor => _hexToColor('#539d82');
  @override
  Color get primaryColor => _hexToColor('#59949c');
  @override
  Color get secondaryColor => _hexToColor('#5aa099');
}

// TODO: Добавить цвета темной темы
