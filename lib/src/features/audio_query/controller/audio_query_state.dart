import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:meta/meta.dart';

/// Pattern matching for [AudioQueryState].
typedef AudioQueryStateMatch<R, S extends AudioQueryState> = R Function(
  S state,
);

/// AudioQueryState.
sealed class AudioQueryState extends _$AudioQueryStateBase {
  /// {@macro audio_query_state}
  const AudioQueryState({
    required super.songs,
    required super.albums,
    required super.artists,
    required super.message,
  });

  /// Idling state
  /// {@macro audio_query_state}
  const factory AudioQueryState.idle({
    required List<SongInfo> songs,
    required List<AlbumInfo> albums,
    required List<ArtistInfo> artists,
    String message,
    String? error,
  }) = AudioQueryState$Idle;

  /// Processing
  /// {@macro audio_query_state}
  const factory AudioQueryState.processing({
    required List<SongInfo> songs,
    required List<AlbumInfo> albums,
    required List<ArtistInfo> artists,
    String message,
  }) = AudioQueryState$Processing;
}

/// Idling state

final class AudioQueryState$Idle extends AudioQueryState {
  const AudioQueryState$Idle({
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

final class AudioQueryState$Processing extends AudioQueryState {
  const AudioQueryState$Processing({
    required super.songs,
    required super.albums,
    required super.artists,
    super.message = 'Processing ',
  });

  @override
  String? get error => null;
}

@immutable
abstract base class _$AudioQueryStateBase {
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
    required AudioQueryStateMatch<R, AudioQueryState$Idle> idle,
    required AudioQueryStateMatch<R, AudioQueryState$Processing> processing,
  }) =>
      switch (this) {
        final AudioQueryState$Idle s => idle(s),
        final AudioQueryState$Processing s => processing(s),
        _ => throw AssertionError(),
      };

  /// Pattern matching for [AudioQueryState].
  R maybeMap<R>({
    required R Function() orElse,
    AudioQueryStateMatch<R, AudioQueryState$Idle>? idle,
    AudioQueryStateMatch<R, AudioQueryState$Processing>? processing,
  }) =>
      map<R>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
      );

  /// Pattern matching for [AudioQueryState].
  R? mapOrNull<R>({
    AudioQueryStateMatch<R, AudioQueryState$Idle>? idle,
    AudioQueryStateMatch<R, AudioQueryState$Processing>? processing,
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
