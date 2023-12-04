import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../features/dependencies/scope/dependencies_scope.dart';
import '../../features/music_player/scope/music_player_root_scope.dart';
import '../localization/localization.dart';
import '../router/application_navigation.dart';
import '../theme/theme_constants.dart';
import '../theme/theme_manager.dart';
import '../theme/widget/application_theme.dart';
import 'window_scope.dart';

/// {@template app}
/// App widget
/// {@endtemplate}
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
              //FIXME: No ApplicationTheme found in context
              themeMode: ApplicationTheme.of(context).themeManager.themeMode,
              supportedLocales: Localization.supportedLocales,
              locale: const Locale('en', 'US'), //TODO: add localization
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                child: WindowScope(
                  title: Localization.of(context).title,
                  child: MusicPlayerScope(
                    child: child ?? const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
