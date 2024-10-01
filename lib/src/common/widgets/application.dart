import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:jukebox_music_player/src/common/constant/config.dart';
import 'package:jukebox_music_player/src/common/localization/localization.dart';
import 'package:jukebox_music_player/src/common/router/router_state_mixin.dart';
import 'package:jukebox_music_player/src/common/widgets/window_scope.dart';
import 'package:jukebox_music_player/src/features/audio_query/scope/audio_query_scope.dart';
import 'package:jukebox_music_player/src/features/music_player/scope/music_player_scope.dart';
import 'package:jukebox_music_player/src/features/settings/scope/setting_scope.dart';
import 'package:octopus/octopus.dart';

/// {@template application}
/// The application widget.
/// {@endtemplate
class Application extends StatefulWidget {
  /// {@macro app}
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> with RouterStateMixin {
  // Disable recreate widget tree.
  final Key builderKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final theme = SettingsScope.themeOf(context).theme;
    final locale = SettingsScope.localeOf(context).locale;
    return MaterialApp.router(
      title: 'Jukebox',
      debugShowCheckedModeBanner: !Config.environment.isProduction,
      localizationsDelegates: const <LocalizationsDelegate<Object?>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        Localization.delegate,
      ],
      routerConfig: router.config,
      theme: theme.lightTheme,
      darkTheme: theme.darkTheme,
      themeMode: theme.mode,
      supportedLocales: Localization.supportedLocales,
      locale: locale,
      builder: (context, child) => MediaQuery(
        key: builderKey,
        data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
        child: WindowScope(
          title: Localization.of(context).title,
          child: OctopusTools(
            enable: true,
            octopus: router,
            child: AudioQueryScope(
              child: MusicPlayerScope(
                child: child ?? const SizedBox.shrink(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
