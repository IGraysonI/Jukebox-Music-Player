import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/features/audio_query/scope/audio_query_scope.dart';
import 'package:jukevault/jukevault.dart';
import 'package:just_audio/just_audio.dart';

/// MusicPlayerScope widget.
class MusicPlayerScope extends StatefulWidget {
  /// {@macro music_player_scope}
  const MusicPlayerScope({
    required this.child,
    super.key,
  });

  final Widget child;

  /// Audio player of the MusicPlayer scope
  static AudioPlayer audioPlayerOf(BuildContext context) =>
      _InheritedMusicPlayerScope.of(context, listen: false).audioPlayer;

  static ConcatenatingAudioSource createPlaylist(
    BuildContext context, {
    List<AudioModel>? songs,
    AlbumModel? albumInfo,
    ArtistModel? artistInfo,
  }) {
    final songsForPlaylist = <AudioSource>[];

    if (songs != null) {
      songsForPlaylist.addAll(
        songs.map((song) => AudioSource.file(song.uri!, tag: song)),
      );
    } else if (albumInfo != null) {
      final albumContent = AudioQueryScope.getAlbumById(context, albumInfo.id.toString());
      if (albumContent != null) {
        // TODO:
        // songsForPlaylist.addAll(
        //   albumContent.songs.map((song) => AudioSource.file(song.filePath!, tag: song)),
        // );
      }
    } else if (artistInfo != null) {
      // TODO:
      // final artistContent = AudioQueryScope.getArtistById(context, artistInfo.id.toString());
      // if (artistContent != null) {
      //   final albumContent = artistContent.albums;
      // for (final album in albumContent) {
      // songsForPlaylist.addAll(
      //   album.songs.map((song) => AudioSource.file(song.filePath!, tag: song)),
      // );
      // }
      // }
    } else {
      // TODO:
      // final allSongs = AudioQueryScope.getSongs(context);
      // songsForPlaylist.addAll(
      //   AudioQueryScope.controllerOf(context).state.songs.map((song) => AudioSource.file(song.filePath!, tag: song)),
      // );
    }

    return ConcatenatingAudioSource(
      useLazyPreparation: false,
      children: songsForPlaylist,
    );
  }

  /// Воспроизводит плэйлист
  static void playPlaylist(
    BuildContext context,
    ConcatenatingAudioSource playlist,
    int selectedSongIndex,
  ) =>
      _InheritedMusicPlayerScope.of(context).audioPlayer
        ..setAudioSource(
          playlist,
          initialIndex: selectedSongIndex,
        )
        ..play();

  @override
  State<MusicPlayerScope> createState() => _MusicPlayerScopeState();
}

class _MusicPlayerScopeState extends State<MusicPlayerScope> {
  late final AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _InheritedMusicPlayerScope(
        audioPlayer: _audioPlayer,
        child: widget.child,
      );
}

/// Inherited widget for quick access in the element tree.
class _InheritedMusicPlayerScope extends InheritedWidget {
  const _InheritedMusicPlayerScope({
    required this.audioPlayer,
    required super.child,
  });

  final AudioPlayer audioPlayer;

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  /// For example: `MusicPlayerScope.maybeOf(context)`
  static _InheritedMusicPlayerScope? maybeOf(
    BuildContext context, {
    bool listen = true,
  }) =>
      listen
          ? context.dependOnInheritedWidgetOfExactType<_InheritedMusicPlayerScope>()
          : context.getInheritedWidgetOfExactType<_InheritedMusicPlayerScope>();

  static Never _notFoundInheritedWidgetOfExactType() => throw ArgumentError(
        'Out of scope, not found inherited widget '
            'a _InheritedAudioQueryScope of the exact type',
        'out_of_scope',
      );

  /// The state from the closest instance of this class
  /// that encloses the given context.
  /// For example: `AudioQueryScope.of(context)`
  static _InheritedMusicPlayerScope of(
    BuildContext context, {
    bool listen = true,
  }) =>
      maybeOf(context, listen: listen) ?? _notFoundInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(covariant _InheritedMusicPlayerScope oldWidget) =>
      !identical(audioPlayer, oldWidget.audioPlayer);
}
