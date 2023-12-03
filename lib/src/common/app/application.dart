import 'package:flutter/material.dart';

import '../../common/extensions/build_context_extensions.dart';
import '../../features/audio_query/scope/audio_query_root_scope.dart';
import '../../features/music_player/scope/music_player_root_scope.dart';
import '../router/application_navigation.dart';
import '../theme/theme_constants.dart';
import '../theme/theme_manager.dart';
import 'application_initialization.dart';
import 'application_lifecycle_observer.dart';
import 'application_theme.dart';

/// Корневой виджет
class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) => ApplicationLifecycleObserver(
        child: ApplicationInitialization(
          child: Builder(
            builder: (context) => ApplicationTheme(
              themeManager: ThemeManager(sharedPrefsStore: context.cache),
              child: _Application(),
            ),
          ),
        ),
      );
}

/// Конфигурация корневого виджета
class _Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: ApplicationTheme.of(context).themeManager,
        builder: (context, child) => MaterialApp.router(
          routerConfig: ApplicationNavigation.router,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ApplicationTheme.of(context).themeManager.themeMode,
          builder: (context, child) => _ScopeProvider(
            child: child ?? const SizedBox.shrink(),
          ),
        ),
      );
}

/// Виджет для встраивания скопов по дереву
class _ScopeProvider extends StatelessWidget {
  const _ScopeProvider({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) =>
      AudioQueryRooyScope(child: MusicPlayerScope(child: child));
}
