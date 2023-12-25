import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/features/controller/state_consumer.dart';
import 'package:jukebox_music_player/src/common/extension/context_extension.dart';
import 'package:jukebox_music_player/src/common/theme/application_theme.dart';
import 'package:jukebox_music_player/src/features/dependencies/scope/dependencies_scope.dart';
import 'package:jukebox_music_player/src/features/settings/controller/settings_controller.dart';
import 'package:jukebox_music_player/src/features/settings/controller/settings_state.dart';
import 'package:jukebox_music_player/src/features/settings/enum/setting_scope_aspect_enum.dart';
import 'package:jukebox_music_player/src/features/settings/model/locale_scope_controller.dart';
import 'package:jukebox_music_player/src/features/settings/model/theme_scope_controller.dart';

/// {@template setting_scope_controller}
/// A controller that holds and operates the app settings
/// {@endtemplate}
abstract interface class SettingsScopeController implements IThemeScopeController, ILocaleScopeController {}

/// {@template setting_scope}
/// Setting scope widget.
/// Manages the theme and localization of the application.
/// {@endtemplate}
class SettingsScope extends StatefulWidget {
  /// {@macro setting_scope}
  const SettingsScope({
    required this.child,
    super.key,
  });

  /// The child widget.
  final Widget child;

  /// Get the [SettingsScopeController] of the closest [SettingsScope] ancestor.
  static SettingsScopeController of(
    BuildContext context, {
    bool listen = true,
  }) =>
      context.inhOf<_InheritedSettings>(listen: listen).controller;

  /// Get the [ThemeScopeController] of the closest [SettingsScope] ancestor.
  static IThemeScopeController themeOf(BuildContext context) => context
      .inheritFrom<SettingScopeAspectEnum, _InheritedSettings>(
        aspect: SettingScopeAspectEnum.theme,
      )
      .controller;

  /// Get the [LocaleScopeController] of the closest [SettingsScope] ancestor.
  static ILocaleScopeController localeOf(BuildContext context) => context
      .inheritFrom<SettingScopeAspectEnum, _InheritedSettings>(
        aspect: SettingScopeAspectEnum.locale,
      )
      .controller;

  @override
  State<SettingsScope> createState() => _SettingsScopeState();
}

class _SettingsScopeState extends State<SettingsScope> implements SettingsScopeController {
  late final SettingsController _settingController;

  @override
  void initState() {
    super.initState();
    _settingController = SettingsController(DependenciesScope.of(context).settingsRepository);
  }

  @override
  void dispose() {
    _settingController.dispose();
    super.dispose();
  }

  @override
  void setLocale(Locale locale) => _settingController.updateLocale(locale: locale);

  @override
  void setThemeMode(ThemeMode themeMode) => _settingController.updateTheme(
        applicationTheme: ApplicationTheme(
          mode: themeMode,
          seed: theme.seed,
        ),
      );

  @override
  void setThemeSeedColor(Color color) => _settingController.updateTheme(
        applicationTheme: ApplicationTheme(
          mode: theme.mode,
          seed: color,
        ),
      );

  @override
  Locale get locale => _settingController.state.locale;

  @override
  ApplicationTheme get theme => _settingController.state.applicationTheme;

  @override
  Widget build(BuildContext context) => StateConsumer(
        controller: _settingController,
        builder: (context, state, child) => _InheritedSettings(
          controller: this,
          state: state,
          child: widget.child,
        ),
      );
}

/// {@template _inherited_settings}
/// InheritedSettings widget.
/// {@endtemplate}
class _InheritedSettings extends InheritedModel<SettingScopeAspectEnum> {
  /// {@macro _inherited_settings}
  const _InheritedSettings({
    required this.controller,
    required this.state,
    required super.child,
  });

  final SettingsScopeController controller;
  final SettingsState state;

  @override
  bool updateShouldNotify(_InheritedSettings oldWidget) => state != oldWidget.state;

  @override
  bool updateShouldNotifyDependent(
    covariant _InheritedSettings oldWidget,
    Set<SettingScopeAspectEnum> dependencies,
  ) {
    var shouldNotify = false;
    if (dependencies.contains(SettingScopeAspectEnum.theme)) {
      shouldNotify = shouldNotify || state.applicationTheme != oldWidget.state.applicationTheme;
    }
    if (dependencies.contains(SettingScopeAspectEnum.locale)) {
      final locale = state.locale.languageCode;
      final oldLocale = oldWidget.state.locale.languageCode;
      shouldNotify = shouldNotify || locale != oldLocale;
    }
    return shouldNotify;
  }
}
