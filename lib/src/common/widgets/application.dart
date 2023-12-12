import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:jukebox_music_player/src/features/audio_query/scope/audio_query_scope.dart';
import 'package:jukebox_music_player/src/features/dependencies/scope/dependencies_scope.dart';
import 'package:jukebox_music_player/src/features/music_player/scope/music_player_scope.dart';
import 'package:jukebox_music_player/src/common/localization/localization.dart';
import 'package:jukebox_music_player/src/common/router/application_navigation.dart';
import 'package:jukebox_music_player/src/common/theme/theme_constants.dart';
import 'package:jukebox_music_player/src/common/theme/theme_manager.dart';
import 'package:jukebox_music_player/src/common/theme/widget/application_theme.dart';
import 'package:jukebox_music_player/src/common/widgets/window_scope.dart';

/// Application widget
class Application extends StatelessWidget {
  /// {@macro app}
  const Application({super.key});

  //TODO: change manager and ApplicationTheme
  @override
  Widget build(BuildContext context) => ApplicationTheme(
        themeManager: ThemeManager(
          sharedPrefsStore: DependenciesScope.of(context).sharedPrefsStore,
        ),
        child: Builder(
          builder: (context) => AnimatedBuilder(
            animation: ApplicationTheme.of(context).themeManager,
            builder: (context, child) => MaterialApp.router(
              title: 'Jukebox',
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const <LocalizationsDelegate<Object?>>[
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                Localization.delegate,
              ],
              routerConfig: ApplicationNavigation.router,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ApplicationTheme.of(context).themeManager.themeMode,
              supportedLocales: Localization.supportedLocales,
              locale: const Locale('en', 'US'), //TODO: add localization
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: const TextScaler.linear(1)),
                child: WindowScope(
                  title: Localization.of(context).title,
                  child: AudioQueryScope(
                    child: MusicPlayerScope(
                      child: child ?? const SizedBox.shrink(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
