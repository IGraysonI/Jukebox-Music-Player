import 'package:flutter/material.dart';

import 'color/color_scheme.dart';

// Color get _shadowColor => lightColorPallete.primaryColor.withOpacity(.3);

ColorPallete colorPalleteLight = LightColorPallete();

//TODO: Добавить темы для различных компонентов
ThemeData lightThemeData = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: colorPalleteLight.scaffoldBackgroundColor,
  colorScheme: lightColorScheme,
  // textTheme: applicationTextTheme,
);
