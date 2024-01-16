import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/common/widgets/basic/custom_sliver_app_bar.dart';
import 'package:jukebox_music_player/src/features/audio_query/scope/audio_query_scope.dart';
import 'package:jukebox_music_player/src/features/jukebox_music_player/enum/navigation_tabs_enum.dart';
import 'package:jukebox_music_player/src/features/songs/widget/song_card.dart';
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
  @override
  Widget build(BuildContext context) {
    final songs = AudioQueryScope.getSongs(context);
    if (songs.isEmpty) return const Center(child: CircularProgressIndicator());
    return CustomScrollView(
      slivers: [
        const CustomSliverAppBar(title: 'Songs'),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => SongCard(songIndex: index, song: songs[index]),
            childCount: songs.length,
          ),
        ),
      ],
    );
  }
}
