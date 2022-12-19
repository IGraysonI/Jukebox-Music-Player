import 'package:flutter/material.dart';

import '../../core/logger/l.dart';
import '../router/application_navigation.dart';
import '../theme/application_theme.dart';
import '../theme/theme_constants.dart';
import 'application_initialization.dart';

/// Корневой виджет
class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ApplicationInitialization(
        child: _Application(),
      );

  static _ApplicationState of(BuildContext context) =>
      context.findAncestorStateOfType<_ApplicationState>()!;
}

/// Конфигурация корневого виджета
class _Application extends StatefulWidget {
  @override
  State<_Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<_Application> {
  late final ApplicationNavigation _navigation;
  late final ThemeManager _themeManager;

  @override
  void initState() {
    l.i('Приложение запущено');
    _navigation = ApplicationNavigation();
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
