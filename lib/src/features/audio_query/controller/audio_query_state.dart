import 'package:jukebox_music_player/src/common/controller/state_base.dart';
import 'package:jukevault/jukevault.dart';
import 'package:meta/meta.dart';

/// Pattern matching for [AudioQueryState].
typedef AudioQueryStateMatch<R, S extends AudioQueryState> = R Function(S state);

/// {@template audio_query_state}
/// AudioQueryState.
/// {@endtemplate}
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
    required List<AudioModel> songs,
    required List<AlbumModel> albums,
    required List<ArtistModel> artists,
    String message,
  }) = AudioQueryState$Idle;

  /// Processing
  /// {@macro audio_query_state}
  const factory AudioQueryState.processing({
    required List<AudioModel> songs,
    required List<AlbumModel> albums,
    required List<ArtistModel> artists,
    String message,
  }) = AudioQueryState$Processing;

  /// Succesful
  /// {@macro audio_query_state}
  const factory AudioQueryState.successful({
    required List<AudioModel> songs,
    required List<AlbumModel> albums,
    required List<ArtistModel> artists,
    String message,
  }) = AudioQueryState$Successful;

  /// An error has occurred
  /// {@macro audio_query_state}
  const factory AudioQueryState.error({
    required List<AudioModel> songs,
    required List<AlbumModel> albums,
    required List<ArtistModel> artists,
    String message,
  }) = AudioQueryState$Error;
}

/// Idling state
final class AudioQueryState$Idle extends AudioQueryState {
  const AudioQueryState$Idle({
    required super.songs,
    required super.albums,
    required super.artists,
    super.message = 'Idling',
  });
}

/// Processing
final class AudioQueryState$Processing extends AudioQueryState {
  const AudioQueryState$Processing({
    required super.songs,
    required super.albums,
    required super.artists,
    super.message = 'Processing ',
  });
}

/// Succesful
final class AudioQueryState$Successful extends AudioQueryState {
  const AudioQueryState$Successful({
    required super.songs,
    required super.albums,
    required super.artists,
    super.message = 'Successful',
  });
}

/// Error
final class AudioQueryState$Error extends AudioQueryState {
  const AudioQueryState$Error({
    required super.songs,
    required super.albums,
    required super.artists,
    super.message = 'Error',
  });
}

@immutable
abstract base class _$AudioQueryStateBase extends StateBase<AudioQueryState> {
  const _$AudioQueryStateBase({
    required this.songs,
    required this.albums,
    required this.artists,
    required super.message,
  });

  /// Song list from device.
  @nonVirtual
  final List<AudioModel> songs;

  /// Album list from device.
  @nonVirtual
  final List<AlbumModel> albums;

  /// Artist list from device.
  @nonVirtual
  final List<ArtistModel> artists;

  /// Is in progress state?
  @override
  bool get isProcessing => maybeMap<bool>(orElse: () => false, processing: (_) => true);

  /// Pattern matching for [AudioQueryState].
  @override
  R map<R>({
    required AudioQueryStateMatch<R, AudioQueryState$Idle> idle,
    required AudioQueryStateMatch<R, AudioQueryState$Processing> processing,
    required AudioQueryStateMatch<R, AudioQueryState$Successful> successful,
    required AudioQueryStateMatch<R, AudioQueryState$Error> error,
  }) =>
      switch (this) {
        final AudioQueryState$Idle s => idle(s),
        final AudioQueryState$Processing s => processing(s),
        final AudioQueryState$Successful s => successful(s),
        final AudioQueryState$Error s => error(s),
        _ => throw AssertionError(),
      };

  /// Pattern matching for [AudioQueryState].
  @override
  R maybeMap<R>({
    required R Function() orElse,
    AudioQueryStateMatch<R, AudioQueryState$Idle>? idle,
    AudioQueryStateMatch<R, AudioQueryState$Processing>? processing,
    AudioQueryStateMatch<R, AudioQueryState$Successful>? successful,
    AudioQueryStateMatch<R, AudioQueryState$Error>? error,
  }) =>
      map<R>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        successful: successful ?? (_) => orElse(),
        error: error ?? (_) => orElse(),
      );

  /// Pattern matching for [AudioQueryState].
  @override
  R? mapOrNull<R>({
    AudioQueryStateMatch<R, AudioQueryState$Idle>? idle,
    AudioQueryStateMatch<R, AudioQueryState$Processing>? processing,
    AudioQueryStateMatch<R, AudioQueryState$Successful>? successful,
    AudioQueryStateMatch<R, AudioQueryState$Error>? error,
  }) =>
      map<R?>(
        idle: idle ?? (_) => null,
        processing: processing ?? (_) => null,
        successful: successful ?? (_) => null,
        error: error ?? (_) => null,
      );

  /// Copy with method for [AudioQueryState].
  @override
  AudioQueryState copyWith({
    List<AudioModel>? songs,
    List<AlbumModel>? albums,
    List<ArtistModel>? artists,
    String? message,
    String? error,
  }) =>
      map<AudioQueryState>(
        idle: (s) => AudioQueryState.idle(
          songs: songs ?? s.songs,
          albums: albums ?? s.albums,
          artists: artists ?? s.artists,
          message: message ?? s.message,
        ),
        processing: (s) => AudioQueryState.processing(
          songs: songs ?? s.songs,
          albums: albums ?? s.albums,
          artists: artists ?? s.artists,
          message: message ?? s.message,
        ),
        successful: (s) => AudioQueryState.successful(
          songs: songs ?? s.songs,
          albums: albums ?? s.albums,
          artists: artists ?? s.artists,
          message: message ?? s.message,
        ),
        error: (s) => AudioQueryState.error(
          songs: songs ?? s.songs,
          albums: albums ?? s.albums,
          artists: artists ?? s.artists,
          message: message ?? s.message,
        ),
      );

  @override
  String toString() {
    final buffer = StringBuffer()
      ..write('AudioQueryState(')
      ..write('songs: ${songs.length}, ')
      ..write('albums: ${albums.length}, ')
      ..write('artists: ${artists.length} ')
      ..write('message: $message')
      ..write(')');
    return buffer.toString();
  }
}
