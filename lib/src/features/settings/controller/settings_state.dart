import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/common/controller/state_base.dart';
import 'package:jukebox_music_player/src/common/theme/application_theme.dart';
import 'package:meta/meta.dart';

/// Pattern matching for [SettingsState].
typedef SettingStateMatch<R, S extends SettingsState> = R Function(S state);

/// SettingState.
sealed class SettingsState extends _$SettingStateBase {
  /// {@macro setting_state}
  const SettingsState({
    required super.locale,
    required super.applicationTheme,
    required super.message,
  });

  /// Idling state
  /// {@macro setting_state}
  const factory SettingsState.idle({
    required Locale locale,
    required ApplicationTheme applicationTheme,
    String message,
  }) = SettingState$Idle;

  /// Processing
  /// {@macro setting_state}
  const factory SettingsState.processing({
    required Locale locale,
    required ApplicationTheme applicationTheme,
    String message,
  }) = SettingState$Processing;

  /// Succesful
  /// {@macro setting_state}
  const factory SettingsState.successful({
    required Locale locale,
    required ApplicationTheme applicationTheme,
    String message,
  }) = SettingState$Successful;

  /// An error has occurred
  /// {@macro setting_state}
  const factory SettingsState.error({
    required Locale locale,
    required ApplicationTheme applicationTheme,
    String message,
  }) = SettingState$Error;
}

/// Idling state
final class SettingState$Idle extends SettingsState {
  const SettingState$Idle({
    required super.locale,
    required super.applicationTheme,
    super.message = 'Idling',
  });
}

/// Processing
final class SettingState$Processing extends SettingsState {
  const SettingState$Processing({
    required super.locale,
    required super.applicationTheme,
    super.message = 'Processing ',
  });
}

/// Succesful
final class SettingState$Successful extends SettingsState {
  const SettingState$Successful({
    required super.locale,
    required super.applicationTheme,
    super.message = 'Successful',
  });
}

/// Error
final class SettingState$Error extends SettingsState {
  const SettingState$Error({
    required super.locale,
    required super.applicationTheme,
    super.message = 'An error has occurred',
  });
}

@immutable
abstract base class _$SettingStateBase extends StateBase<SettingsState> {
  const _$SettingStateBase({
    required this.locale,
    required this.applicationTheme,
    required super.message,
  });

  /// Locale of the application.
  @nonVirtual
  final Locale locale;

  /// The theme of the application.
  @nonVirtual
  final ApplicationTheme applicationTheme;

  /// Pattern matching for [SettingsState].
  @override
  R map<R>({
    required SettingStateMatch<R, SettingState$Idle> idle,
    required SettingStateMatch<R, SettingState$Processing> processing,
    required SettingStateMatch<R, SettingState$Successful> successful,
    required SettingStateMatch<R, SettingState$Error> error,
  }) =>
      switch (this) {
        final SettingState$Idle s => idle(s),
        final SettingState$Processing s => processing(s),
        final SettingState$Successful s => successful(s),
        final SettingState$Error s => error(s),
        _ => throw AssertionError(),
      };

  /// Pattern matching for [SettingsState].
  @override
  R maybeMap<R>({
    required R Function() orElse,
    SettingStateMatch<R, SettingState$Idle>? idle,
    SettingStateMatch<R, SettingState$Processing>? processing,
    SettingStateMatch<R, SettingState$Successful>? successful,
    SettingStateMatch<R, SettingState$Error>? error,
  }) =>
      map<R>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        successful: successful ?? (_) => orElse(),
        error: error ?? (_) => orElse(),
      );

  /// Pattern matching for [SettingsState].
  @override
  R? mapOrNull<R>({
    SettingStateMatch<R, SettingState$Idle>? idle,
    SettingStateMatch<R, SettingState$Processing>? processing,
    SettingStateMatch<R, SettingState$Successful>? successful,
    SettingStateMatch<R, SettingState$Error>? error,
  }) =>
      map<R?>(
        idle: idle ?? (_) => null,
        processing: processing ?? (_) => null,
        successful: successful ?? (_) => null,
        error: error ?? (_) => null,
      );

  /// Copy with method for [SettingsState].
  @override
  SettingsState copyWith({
    Locale? locale,
    ApplicationTheme? applicationTheme,
    String? message,
    String? error,
  }) =>
      map(
        idle: (s) => s.copyWith(
          locale: locale ?? s.locale,
          applicationTheme: applicationTheme ?? s.applicationTheme,
          message: message ?? s.message,
        ),
        processing: (s) => s.copyWith(
          locale: locale ?? s.locale,
          applicationTheme: applicationTheme ?? s.applicationTheme,
          message: message ?? s.message,
        ),
        successful: (s) => s.copyWith(
          locale: locale ?? s.locale,
          applicationTheme: applicationTheme ?? s.applicationTheme,
          message: message ?? s.message,
        ),
        error: (s) => s.copyWith(
          locale: locale ?? s.locale,
          applicationTheme: applicationTheme ?? s.applicationTheme,
          message: message ?? s.message,
        ),
      );

  @override
  String toString() {
    final buffer = StringBuffer()
      ..write('SettingState(')
      ..write('locale: ${locale.languageCode}, ')
      ..write('applicationTheme mode: ${applicationTheme.mode}')
      ..write('applicationTheme seed: ${applicationTheme.seed}')
      ..write('message: $message')
      ..write(')');
    return buffer.toString();
  }
}
