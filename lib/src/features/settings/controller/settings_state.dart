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
    String? error,
  }) = SettingState$Idle;

  /// Processing
  /// {@macro setting_state}
  const factory SettingsState.processing({
    required Locale locale,
    required ApplicationTheme applicationTheme,
    String message,
  }) = SettingState$Processing;
}

/// Idling state
final class SettingState$Idle extends SettingsState {
  const SettingState$Idle({
    required super.locale,
    required super.applicationTheme,
    super.message = 'Idling',
    this.error,
  });

  @override
  final String? error;
}

/// Processing
final class SettingState$Processing extends SettingsState {
  const SettingState$Processing({
    required super.locale,
    required super.applicationTheme,
    super.message = 'Processing ',
  });

  @override
  String? get error => null;
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

  /// Is in progress state?
  @override
  bool get isProcessing =>
      maybeMap<bool>(orElse: () => false, processing: (_) => true);

  /// Pattern matching for [SettingsState].
  @override
  R map<R>({
    required SettingStateMatch<R, SettingState$Idle> idle,
    required SettingStateMatch<R, SettingState$Processing> processing,
  }) =>
      switch (this) {
        final SettingState$Idle s => idle(s),
        final SettingState$Processing s => processing(s),
        _ => throw AssertionError(),
      };

  /// Pattern matching for [SettingsState].
  @override
  R maybeMap<R>({
    required R Function() orElse,
    SettingStateMatch<R, SettingState$Idle>? idle,
    SettingStateMatch<R, SettingState$Processing>? processing,
  }) =>
      map<R>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
      );

  /// Pattern matching for [SettingsState].
  @override
  R? mapOrNull<R>({
    SettingStateMatch<R, SettingState$Idle>? idle,
    SettingStateMatch<R, SettingState$Processing>? processing,
  }) =>
      map<R?>(
        idle: idle ?? (_) => null,
        processing: processing ?? (_) => null,
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
          error: error ?? s.error,
        ),
        processing: (s) => s.copyWith(
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
      ..write('applicationTheme seed: ${applicationTheme.seed}');
    if (error != null) buffer.write('error: $error, ');
    buffer
      ..write('message: $message')
      ..write(')');
    return buffer.toString();
  }
}
