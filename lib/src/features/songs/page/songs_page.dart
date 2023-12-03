import 'package:flutter/material.dart';

class SongsPage extends StatefulWidget {
  const SongsPage({super.key});

  static _SongsPageState of(BuildContext context) =>
      context.findAncestorStateOfType<_SongsPageState>()!;

  static String page() => 'SongsPage';

  @override
  State<SongsPage> createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
  @override
  Widget build(BuildContext context) => CustomScrollView(
        slivers: [
          const SliverAppBar(title: Text('Songs'), floating: true, snap: true),
          // BlocBuilder<AudioQueryBloc, AudioQueryState>(
          //   bloc: AudioQueryRooyScope.of(context).audioQueryBloc,
          //   builder: (context, state) =>
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) =>
                  // SongCard(songIndex: index, song: state.songs[index]),
                  const Text('s'),
              // childCount: state.songs.length,
              childCount: 2,
            ),
          ),
          // ),
        ],
      );
}
