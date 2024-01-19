import 'dart:io';

import 'package:control/control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:jukebox_music_player/src/common/extension/string_extensions.dart';
import 'package:jukebox_music_player/src/common/model/dependencies.dart';
import 'package:jukebox_music_player/src/common/widgets/basic/application_sliver_app_bar.dart';
import 'package:jukebox_music_player/src/features/audio_query/controller/audio_query_controller.dart';
import 'package:jukebox_music_player/src/features/audio_query/controller/audio_query_state.dart';
import 'package:jukebox_music_player/src/features/audio_query/scope/audio_query_scope.dart';
import 'package:jukebox_music_player/src/features/jukebox_music_player/enum/navigation_tabs_enum.dart';
import 'package:jukebox_music_player/src/features/music_player/scope/music_player_scope.dart';
import 'package:octopus/octopus.dart';

/// {@template songs_tab}
/// SongsTab widget.
/// {@endtemplate}
class SongsTab extends StatelessWidget {
  /// {@macro songs_tab}
  const SongsTab({super.key});

  @override
  Widget build(BuildContext context) => BucketNavigator(
        bucket: '${NavigationTabsEnum.songs}-tab',
      );
}

/// {@template songs_screen}
/// SongsScreen widget.
/// {@endtemplate}
class SongsScreen extends StatefulWidget {
  /// {@macro songs_screen}
  const SongsScreen({super.key});

  @override
  State<SongsScreen> createState() => SongsScreenState();
}

class SongsScreenState extends State<SongsScreen> {
  late final AudioQueryController _audioQueryController;

  @override
  void initState() {
    super.initState();
    _audioQueryController = Dependencies.of(context).audioQueryController;
  }

  void _showSnakBar(SnackBar snackBar) => ScaffoldMessenger.maybeOf(context)
    ?..clearSnackBars()
    ..showSnackBar(snackBar);

  void _onStateChanged(
    BuildContext context,
    AudioQueryController controller,
    AudioQueryState previousState,
    AudioQueryState nextState,
  ) {
    switch (nextState) {
      case AudioQueryState$Successful state:
        _showSnakBar(
          SnackBar(
            content: Text('Successfully loaded ${state.songs.length} songs}'),
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.green,
          ),
        );
      case AudioQueryState$Error state:
        _showSnakBar(
          SnackBar(
            content: Text('Error: ${state.message}'),
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.red,
          ),
        );
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final songs = AudioQueryScope.getSongs(context);
    if (songs.isEmpty) return const Center(child: CircularProgressIndicator());
    return StateConsumer<AudioQueryController, AudioQueryState>(
      controller: _audioQueryController,
      listener: _onStateChanged,
      builder: (context, state, child) => AnimatedOpacity(
        opacity: state.isProcessing ? 0.5 : 1,
        duration: const Duration(milliseconds: 350),
        child: IgnorePointer(
          ignoring: state.isProcessing,
          child: CustomScrollView(
            slivers: [
              const ApplicationSliverAppBar(title: 'Songs'),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _SongCard(
                    songIndex: index,
                    song: songs[index],
                  ),
                  childCount: songs.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SongCard extends StatelessWidget {
  const _SongCard({
    required this.songIndex,
    required this.song,
    this.album,
  });

  final int songIndex;
  final SongInfo song;
  final AlbumInfo? album;

  @override
  Widget build(BuildContext context) => ListTile(
        leading: song.albumArtwork != null
            ? Image(image: FileImage(File(song.albumArtwork!)))
            : const Image(image: AssetImage('assets/images/no_image.jpg')),
        title: Text(song.title!),
        subtitle: Row(
          children: [
            Flexible(
              child: Text(
                song.artist!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Text(' • '),
            Text(song.duration!.getDurationForSongLenght()),
          ],
        ),
        trailing: const Icon(Icons.more_vert_rounded, color: Colors.black),
        onTap: () => MusicPlayerScope.playPlaylist(
          context,
          MusicPlayerScope.createPlaylist(context, albumInfo: album),
          songIndex,
        ),
        dense: false,
      );
}
