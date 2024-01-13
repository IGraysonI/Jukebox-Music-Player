import 'package:control/control.dart';
import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/common/widgets/basic/custom_sliver_app_bar.dart';
import 'package:jukebox_music_player/src/features/audio_query/controller/audio_query_controller.dart';
import 'package:jukebox_music_player/src/features/audio_query/controller/audio_query_state.dart';
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

  static SongsScreenState of(BuildContext context) =>
      context.findAncestorStateOfType<SongsScreenState>()!;

  static String page() => 'SongsPage';

  @override
  State<SongsScreen> createState() => SongsScreenState();
}

class SongsScreenState extends State<SongsScreen> {
  @override
  Widget build(BuildContext context) => CustomScrollView(
        slivers: [
          const CustomSliverAppBar(title: 'Songs'),
          StateConsumer<AudioQueryController, AudioQueryState>(
            controller: AudioQueryScope.controllerOf(context),
            builder: (context, state, _) => switch (state) {
              AudioQueryState$Processing() => const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                ),
              AudioQueryState$Idle() => SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) =>
                        SongCard(songIndex: index, song: state.songs[index]),
                    childCount: state.songs.length,
                  ),
                ),
            },
          ),
        ],
      );
}
