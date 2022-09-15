import 'package:flutter/material.dart';

import '../../core/logger/l.dart';
import '../router/app_navigation.dart';
import '../theme/application_theme.dart';
import '../theme/theme_constants.dart';
import 'application_initialization.dart';

/// Корневой виджет
class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      ApplicationInitialization(child: _Application());

  static _ApplicationState of(BuildContext context) =>
      context.findAncestorStateOfType<_ApplicationState>()!;
}

/// Конфигурация конверого виджета
class _Application extends StatefulWidget {
  @override
  State<_Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<_Application> {
  /// Навигация приложения
  late final AppNavigation _navigation;
  late final ThemeManager _themeManager;

  /// В случае если NULL локализация будет взята по умолчанию, первая из списка
  // Locale? _locale;

  /// Позволяет изменить локализацию приложения
  // void setLocale(Locale locale) => setState(() => _locale = locale);

  @override
  void initState() {
    l.i('Приложение запущено');
    _navigation = AppNavigation();
    _themeManager = ThemeManager();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: _themeManager,
        builder: (context, child) => MaterialApp.router(
          routeInformationProvider: _navigation.router.routeInformationProvider,
          routeInformationParser: _navigation.router.routeInformationParser,
          routerDelegate: _navigation.router.routerDelegate,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: _themeManager.themeMode,
          // locale: _locale,
        ),
      );
}
