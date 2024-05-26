import 'dart:ui';

import 'package:control/control.dart';
import 'package:jukebox_music_player/src/common/localization/localization.dart';
import 'package:jukebox_music_player/src/common/theme/application_theme.dart';
import 'package:jukebox_music_player/src/common/util/error_util.dart';
import 'package:jukebox_music_player/src/features/settings/controller/settings_state.dart';
import 'package:jukebox_music_player/src/features/settings/data/settings_repository.dart';

/// {@template settings_controller}
/// A [StateController] that handles the settings of the application.
/// {@endtemplate}
final class SettingsController extends StateController<SettingsState> with DroppableControllerHandler {
  SettingsController({
    required ISettingsRepository settingsRepository,
    SettingsState? initialState,
  })  : _settingsRepository = settingsRepository,
        super(
          initialState: initialState ??
              SettingsState.idle(
                locale: settingsRepository.fetchLocaleFromCache() ?? Localization.computeDefaultLocale(),
                applicationTheme: settingsRepository.fetchThemeFromCache() ?? ApplicationTheme.defaultTheme,
                message: 'Initial state',
              ),
        );

  final ISettingsRepository _settingsRepository;

  /// Update the theme of the application by passed [ApplicationTheme]
  void updateTheme({required ApplicationTheme applicationTheme}) => handle(
        () async {
          setState(
            SettingsState.processing(
              locale: state.locale,
              applicationTheme: state.applicationTheme,
              message: 'Updating theme',
            ),
          );
          await _settingsRepository.setTheme(applicationTheme);
        },
        error: (error, _) async => setState(
          SettingsState.idle(
            locale: state.locale,
            applicationTheme: state.applicationTheme,
            message: 'Error updating theme',
          ),
        ),
        done: () async => setState(
          SettingsState.idle(
            locale: state.locale,
            applicationTheme: applicationTheme,
            message: 'Theme updated',
          ),
        ),
      );

  /// Update the locale of the application by passed [Locale]
  void updateLocale({required Locale locale}) => handle(
        () async {
          setState(
            SettingsState.processing(
              locale: state.locale,
              applicationTheme: state.applicationTheme,
              message: 'Updating locale',
            ),
          );
          await _settingsRepository.setLocale(locale);
          setState(
            SettingsState.successful(
              locale: locale,
              applicationTheme: state.applicationTheme,
              message: 'Locale updated',
            ),
          );
        },
        error: (error, _) async => setState(
          SettingsState.error(
            locale: state.locale,
            applicationTheme: state.applicationTheme,
            message: ErrorUtil.formatMessage(error),
          ),
        ),
        done: () async => setState(
          SettingsState.idle(
            locale: locale,
            applicationTheme: state.applicationTheme,
            message: 'Locale updated',
          ),
        ),
      );
}
