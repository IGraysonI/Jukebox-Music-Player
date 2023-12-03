import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayerScope extends StatefulWidget {
  const MusicPlayerScope({required this.child, super.key});

  final Widget child;

  static _MusicPlayerScopeState of(BuildContext context) =>
      context.findAncestorStateOfType<_MusicPlayerScopeState>()!;

  static _MusicPlayerScopeState? stateOf(BuildContext context) => (context
          .getElementForInheritedWidgetOfExactType<
              _InheritedMusicPlayerRootScope>()
          ?.widget as _InheritedMusicPlayerRootScope?)
      ?.state;

  static ConcatenatingAudioSource createPlaylist(
    BuildContext context, {
    List<SongInfo>? songs,
    AlbumInfo? albumInfo,
    ArtistInfo? artistInfo,
  }) {
    final songsForPlaylist = <AudioSource>[];

    // if (songs != null) {
    // songsForPlaylist.addAll(
    //   songs.map((song) => AudioSource.file(song.filePath!, tag: song)),
    // );
    // } else if (albumInfo != null) {
    //   songsForPlaylist.addAll(
    //     AudioQueryRooyScope.stateOf(context)!
    //         .audioQueryBloc
    //         .state
    //         .songs
    //         .where((song) => song.albumId == albumInfo.id)
    //         .map((song) => AudioSource.file(song.filePath!, tag: song)),
    //   );
    // } else if (artistInfo != null) {
    //   songsForPlaylist.addAll(
    //     AudioQueryRooyScope.stateOf(context)!
    //         .audioQueryBloc
    //         .state
    //         .songs
    //         .where((song) => song.artistId == artistInfo.id)
    //         .map((song) => AudioSource.file(song.filePath!, tag: song)),
    //   );
    // } else {
    //   songsForPlaylist.addAll(
    //     AudioQueryRooyScope.stateOf(context)!
    //         .audioQueryBloc
    //         .state
    //         .songs
    //         .map((song) => AudioSource.file(song.filePath!, tag: song)),
    //   );
    // }

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
      of(context).player
        ..setAudioSource(
          playlist,
          initialIndex: selectedSongIndex,
        )
        ..play();

  @override
  State<MusicPlayerScope> createState() => _MusicPlayerScopeState();
}

class _MusicPlayerScopeState extends State<MusicPlayerScope> {
  AudioPlayer? _audioPlayer;

  AudioPlayer get player => _audioPlayer!;

  @override
  void didChangeDependencies() {
    _audioPlayer = AudioPlayer();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _audioPlayer?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _InheritedMusicPlayerRootScope(
        state: this,
        child: widget.child,
      );
}

/// Инхеритит виджет для быстрого доступа в древе виджетов
class _InheritedMusicPlayerRootScope extends InheritedWidget {
  const _InheritedMusicPlayerRootScope({
    required this.state,
    required super.child,
  });

  final _MusicPlayerScopeState state;

  @override
  bool updateShouldNotify(_InheritedMusicPlayerRootScope oldWidget) =>
      state != oldWidget.state;
}
