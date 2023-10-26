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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Text(index.toString()),
              // => SongCard(songIndex: index, song: songs[index]),
              childCount: 10,
            ),
          ),
        ],
      );
}
