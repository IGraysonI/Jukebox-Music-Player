import 'package:flutter/material.dart';

import '../../../common/controller/state_consumer.dart';
import '../../audio_query/controller/audio_query_controller.dart';
import '../../audio_query/controller/audio_query_state.dart';
import '../../audio_query/scope/audio_query_scope.dart';
import '../widget/song_card.dart';

class SongsPage extends StatefulWidget {
  const SongsPage({super.key});

  static _SongsPageState of(BuildContext context) =>
      context.findAncestorStateOfType<_SongsPageState>()!;

  static String page() => 'SongsPage';

  @override
  State<SongsPage> createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
  late final AudioQueryController _audioQueryController;

  @override
  void initState() {
    super.initState();
    _audioQueryController = AudioQueryScope.controllerOf(context);
  }

  @override
  void dispose() {
    _audioQueryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CustomScrollView(
        slivers: [
          const SliverAppBar(title: Text('Songs'), floating: true, snap: true),
          StateConsumer<AudioQueryState>(
            controller: _audioQueryController,
            builder: (context, state, _) => SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) =>
                    SongCard(songIndex: index, song: state.songs[index]),
                // const Text('s'),
                childCount: state.songs.length,
                // childCount: 2,
              ),
            ),
          ),
        ],
      );
}
