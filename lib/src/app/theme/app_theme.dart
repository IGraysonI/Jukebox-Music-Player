import 'package:flutter/material.dart';

class AppTheme extends InheritedWidget {
  const AppTheme(this.themeData, {required super.child, Key? key})
      : super(key: key);

  final ThemeData themeData;

  @override
  bool updateShouldNotify(AppTheme oldWidget) =>
      oldWidget.themeData != themeData;
}

mixin ThemeManager implements ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isLightTheme => _themeMode == ThemeMode.light;
  bool get isDarkTheme => !isLightTheme;

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
