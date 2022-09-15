import 'package:flutter/material.dart';

import 'color/color_scheme.dart';
import 'text/text_theme.dart';

Color get _shadowColor => lightColorPallete.primaryColor.withOpacity(.3);

ColorPallete colorPalleteLight = LightColorPallete();

ThemeData lightThemeData = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: colorPalleteLight.scaffoldBackgroundColor,
  colorScheme: lightColorScheme,
  textTheme: applicationTextTheme,
);
