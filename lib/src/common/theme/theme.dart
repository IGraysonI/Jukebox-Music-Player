import 'package:flutter/material.dart';

import 'package:jukebox_music_player/src/common/theme/color/color_scheme.dart';

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
