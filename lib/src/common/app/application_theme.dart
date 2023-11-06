import 'package:flutter/material.dart';

import '../theme/theme_manager.dart';

/// Виджет темы, находится в корне виджетов приложения
class ApplicationTheme extends InheritedWidget {
  const ApplicationTheme({
    required super.child,
    required this.themeManager,
    super.key,
  });

  final ThemeManager themeManager;

  static ApplicationTheme of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<ApplicationTheme>();
    assert(result != null, 'No ApplicationTheme found in context');
    return result!;
  }

  static bool isDarkTheme(BuildContext context) =>
      ApplicationTheme.of(context).themeManager.isDarkTheme;

  static bool isLightTheme(BuildContext context) =>
      ApplicationTheme.of(context).themeManager.isLightTheme;

  static Future<void> switchToDarkTheme(BuildContext context) =>
      ApplicationTheme.of(context)
          .themeManager
          .toogleTheme(themeMode: ThemeMode.dark);

  static Future<void> switchToLightTheme(BuildContext context) =>
      ApplicationTheme.of(context)
          .themeManager
          .toogleTheme(themeMode: ThemeMode.light);

  @override
  bool updateShouldNotify(ApplicationTheme oldWidget) =>
      themeManager.themeMode != oldWidget.themeManager.themeMode;
}
