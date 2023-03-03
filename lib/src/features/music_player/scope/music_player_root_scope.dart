import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../bloc/music_player_bloc.dart';

class MusicPlayerRootScope extends StatefulWidget {
  const MusicPlayerRootScope({required this.child, Key? key}) : super(key: key);

  final Widget child;

  static _MusicPlayerRootScopeState of(BuildContext context) =>
      context.findAncestorStateOfType<_MusicPlayerRootScopeState>()!;

  static _MusicPlayerRootScopeState? stateOf(BuildContext context) => (context
          .getElementForInheritedWidgetOfExactType<
              _InheritedMusicPlayerRootScope>()
          ?.widget as _InheritedMusicPlayerRootScope?)
      ?.state;

  /// Воспроизводит плэйлист
  static void playPlaylist(
    BuildContext context,
    ConcatenatingAudioSource playlist,
    int selectedSongIndex,
  ) =>
      of(context).musicPlayerBloc.add(
            MusicPlayerEvent.playPlaylist(
              playlist: playlist,
              selectedSongIndex: selectedSongIndex,
            ),
          );

  @override
  State<MusicPlayerRootScope> createState() => _MusicPlayerRootScopeState();
}

class _MusicPlayerRootScopeState extends State<MusicPlayerRootScope> {
  MusicPlayerBloc? _musicPlayerBloc;

  MusicPlayerBloc get musicPlayerBloc => _musicPlayerBloc!;

  @override
  void initState() => super.initState();

  @override
  void didChangeDependencies() {
    _musicPlayerBloc = MusicPlayerBloc();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _musicPlayerBloc?.close();
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

  final _MusicPlayerRootScopeState state;

  @override
  bool updateShouldNotify(_InheritedMusicPlayerRootScope oldWidget) =>
      state != oldWidget.state;
}