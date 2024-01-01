import 'package:flutter/material.dart';

import 'package:jukebox_music_player/src/features/controller/state_consumer.dart';
import 'package:jukebox_music_player/src/common/widgets/basic/custom_sliver_app_bar.dart';
import 'package:jukebox_music_player/src/features/audio_query/controller/audio_query_state.dart';
import 'package:jukebox_music_player/src/features/audio_query/scope/audio_query_scope.dart';
import 'package:jukebox_music_player/src/features/songs/widget/song_card.dart';

class SongsPage extends StatefulWidget {
  const SongsPage({super.key});

  static SongsPageState of(BuildContext context) => context.findAncestorStateOfType<SongsPageState>()!;

  static String page() => 'SongsPage';

  @override
  State<SongsPage> createState() => SongsPageState();
}

class SongsPageState extends State<SongsPage> {
  @override
  Widget build(BuildContext context) => CustomScrollView(
        slivers: [
          const CustomSliverAppBar(title: 'Songs'),
          StateConsumer<AudioQueryState>(
            controller: AudioQueryScope.controllerOf(context),
            builder: (context, state, _) => switch (state) {
              AudioQueryState$Processing() => const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                ),
              AudioQueryState$Idle() => SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => SongCard(songIndex: index, song: state.songs[index]),
                    childCount: state.songs.length,
                  ),
                ),
            },
          ),
        ],
      );
}
