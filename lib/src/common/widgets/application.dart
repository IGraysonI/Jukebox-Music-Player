import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:jukebox_music_player/src/features/audio_query/scope/audio_query_scope.dart';
import 'package:jukebox_music_player/src/features/music_player/scope/music_player_scope.dart';
import 'package:jukebox_music_player/src/common/localization/localization.dart';
import 'package:jukebox_music_player/src/common/router/application_navigation.dart';
import 'package:jukebox_music_player/src/common/widgets/window_scope.dart';
import 'package:jukebox_music_player/src/features/settings/scope/setting_scope.dart';

/// Application widget
class Application extends StatelessWidget {
  /// {@macro app}
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = SettingsScope.themeOf(context).theme;
    final locale = SettingsScope.localeOf(context).locale;
    return MaterialApp.router(
      title: 'Jukebox',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const <LocalizationsDelegate<Object?>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        Localization.delegate,
      ],
      routerConfig: ApplicationNavigation.router,
      theme: theme.lightTheme,
      darkTheme: theme.darkTheme,
      themeMode: theme.mode,
      supportedLocales: Localization.supportedLocales,
      locale: locale,
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
    );
  }
}
