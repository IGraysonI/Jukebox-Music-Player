import 'package:flutter/material.dart';

class ApplicationTheme extends InheritedWidget {
  const ApplicationTheme(this.themeData, {required super.child, Key? key})
      : super(key: key);

  final ThemeData themeData;

  @override
  bool updateShouldNotify(ApplicationTheme oldWidget) =>
      oldWidget.themeData != themeData;
}

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isLightTheme => _themeMode == ThemeMode.light;
  bool get isDarkTheme => !isLightTheme;

  void toggleTheme({required bool isDark}) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
