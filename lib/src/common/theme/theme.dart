import 'package:flutter/material.dart';

import 'color/color_scheme.dart';

part 'theme_light.dart';
part 'theme_dark.dart';

const colorPalleteLight = LightColorPallete();

AppBarTheme appBarTheme = const AppBarTheme();

BottomNavigationBarThemeData bottomNavigationBarThemeData =
    const BottomNavigationBarThemeData(
  showUnselectedLabels: true,
  showSelectedLabels: true,
  type: BottomNavigationBarType.fixed,
);
