import 'package:flutter/material.dart';

import 'color/color_scheme.dart';

// Color get _shadowColor => lightColorPallete.primaryColor.withOpacity(.3);

ColorPallete colorPalleteLight = LightColorPallete();

//TODO: Добавить темы для различных компонентов
ThemeData lightThemeData = ThemeData(
  brightness: Brightness.light,
  // scaffoldBackgroundColor: colorPalleteLight.scaffoldBackgroundColor,
  // colorScheme: lightColorScheme,
  bottomNavigationBarTheme: _bottomNavigationBarThemeData,
  // appBarTheme: _appBarTheme,
  useMaterial3: true,
  colorSchemeSeed: Colors.green[700],
  // textTheme: applicationTextTheme,
);

BottomNavigationBarThemeData _bottomNavigationBarThemeData =
    BottomNavigationBarThemeData(
  showUnselectedLabels: true,
  showSelectedLabels: true,
  type: BottomNavigationBarType.fixed,
  // backgroundColor: colorPalleteLight.primaryColor,
  // selectedItemColor: colorPalleteLight.secondaryColor,
);

AppBarTheme _appBarTheme = AppBarTheme(iconTheme: _iconThemeData);

IconThemeData _iconThemeData = const IconThemeData(color: Colors.white);
