import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:meta/meta.dart';

/// Pattern matching for [AudioQueryState].
typedef AudioQueryStateMatch<R, S extends AudioQueryState> = R Function(
  S state,
);

/// AudioQueryState.
sealed class AudioQueryState extends _$AudioQueryStateBase {
  /// {@macro authentication_state}
  const AudioQueryState({
    required super.songs,
    required super.albums,
    required super.artists,
    required super.message,
  });

  /// Idling state
  /// {@macro authentication_state}
  const factory AudioQueryState.idle({
    required List<SongInfo> songs,
    required List<AlbumInfo> albums,
    required List<ArtistInfo> artists,
    String message,
    String? error,
  }) = AuthenticationState$Idle;

  /// Processing
  /// {@macro authentication_state}
  const factory AudioQueryState.processing({
    required List<SongInfo> songs,
    required List<AlbumInfo> albums,
    required List<ArtistInfo> artists,
    String message,
  }) = AuthenticationState$Processing;
}

/// {@nodoc}
base mixin _$AuthenticationState on AudioQueryState {}

/// Idling state
/// {@nodoc}
final class AuthenticationState$Idle extends AudioQueryState
    with _$AuthenticationState {
  /// {@nodoc}
  const AuthenticationState$Idle({
    required super.songs,
    required super.albums,
    required super.artists,
    super.message = 'Idling',
    this.error,
  });

  @override
  final String? error;
}

/// Processing
/// {@nodoc}
final class AuthenticationState$Processing extends AudioQueryState
    with _$AuthenticationState {
  /// {@nodoc}
  const AuthenticationState$Processing({
    required super.songs,
    required super.albums,
    required super.artists,
    super.message = 'Processing',
  });

  @override
  String? get error => null;
}

/// {@nodoc}
@immutable
abstract base class _$AudioQueryStateBase {
  /// {@nodoc}
  const _$AudioQueryStateBase({
    required this.songs,
    required this.albums,
    required this.artists,
    required this.message,
  });

  /// Song list from device.
  @nonVirtual
  final List<SongInfo> songs;

  /// Album list from device.
  @nonVirtual
  final List<AlbumInfo> albums;

  /// Artist list from device.
  @nonVirtual
  final List<ArtistInfo> artists;

  /// Message or state description.
  @nonVirtual
  final String message;

  /// Error message.
  abstract final String? error;

  /// If an error has occurred?
  bool get hasError => error != null;

  /// Is in progress state?
  bool get isProcessing =>
      maybeMap<bool>(orElse: () => false, processing: (_) => true);

  /// Is in idle state?
  bool get isIdling => !isProcessing;

  /// Pattern matching for [AudioQueryState].
  R map<R>({
    required AudioQueryStateMatch<R, AuthenticationState$Idle> idle,
    required AudioQueryStateMatch<R, AuthenticationState$Processing> processing,
  }) =>
      switch (this) {
        final AuthenticationState$Idle s => idle(s),
        final AuthenticationState$Processing s => processing(s),
        _ => throw AssertionError(),
      };

  /// Pattern matching for [AudioQueryState].
  R maybeMap<R>({
    required R Function() orElse,
    AudioQueryStateMatch<R, AuthenticationState$Idle>? idle,
    AudioQueryStateMatch<R, AuthenticationState$Processing>? processing,
  }) =>
      map<R>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
      );

  /// Pattern matching for [AudioQueryState].
  R? mapOrNull<R>({
    AudioQueryStateMatch<R, AuthenticationState$Idle>? idle,
    AudioQueryStateMatch<R, AuthenticationState$Processing>? processing,
  }) =>
      map<R?>(
        idle: idle ?? (_) => null,
        processing: processing ?? (_) => null,
      );

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  String toString() {
    final buffer = StringBuffer()
      ..write('AudioQueryState(')
      ..write('songs: ${songs.length}, ')
      ..write('albums: ${albums.length}, ')
      ..write('artists: ${artists.length}');
    if (error != null) buffer.write('error: $error, ');
    buffer
      ..write('message: $message')
      ..write(')');
    return buffer.toString();
  }
}
