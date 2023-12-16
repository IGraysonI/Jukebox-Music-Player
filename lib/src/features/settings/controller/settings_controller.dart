import 'dart:ui';

import 'package:jukebox_music_player/src/common/controller/droppable_controller_concurrency.dart';
import 'package:jukebox_music_player/src/common/controller/state_controller.dart';
import 'package:jukebox_music_player/src/common/localization/localization.dart';
import 'package:jukebox_music_player/src/common/theme/application_theme.dart';
import 'package:jukebox_music_player/src/common/utils/error_util.dart';
import 'package:jukebox_music_player/src/features/settings/controller/settings_state.dart';
import 'package:jukebox_music_player/src/features/settings/data/settings_repository.dart';

/// {@template settings_controller}
/// A [StateController] that handles the settings of the application.
/// {@endtemplate}
final class SettingsController extends StateController<SettingsState>
    with DroppableControllerConcurency {
  SettingsController(this._settingsRepository)
      : super(
          initialState: SettingsState.idle(
            locale: _settingsRepository.fetchLocaleFromCache() ??
                Localization.computeDefaultLocale(),
            applicationTheme: _settingsRepository.fetchThemeFromCache() ??
                ApplicationTheme.defaultTheme,
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
        (error, _) => setState(
          SettingsState.idle(
            locale: state.locale,
            applicationTheme: state.applicationTheme,
            message: 'Error updating theme',
            error: ErrorUtil.formatMessage(error),
          ),
        ),
        () => setState(
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
        },
        (error, _) => setState(
          SettingsState.idle(
            locale: state.locale,
            applicationTheme: state.applicationTheme,
            message: 'Error updating locale',
            error: ErrorUtil.formatMessage(error),
          ),
        ),
        () => setState(
          SettingsState.idle(
            locale: locale,
            applicationTheme: state.applicationTheme,
            message: 'Locale updated',
          ),
        ),
      );
}
