import 'package:flutter/material.dart';

import '../../core/logger/l.dart';
import '../router/application_navigation.dart';
import '../theme/theme_constants.dart';
import 'application_initialization.dart';
import 'application_theme.dart';

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

  @override
  void initState() {
    l.i('Приложение запущено');
    _navigation = ApplicationNavigation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: ApplicationTheme.of(context).themeManager,
        builder: (context, child) => MaterialApp.router(
          routeInformationProvider: _navigation.router.routeInformationProvider,
          routeInformationParser: _navigation.router.routeInformationParser,
          routerDelegate: _navigation.router.routerDelegate,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ApplicationTheme.of(context).themeManager.themeMode,
          builder: (context, child) => child ?? const SizedBox.shrink(),
        ),
      );
}
