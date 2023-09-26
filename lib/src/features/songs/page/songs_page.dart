import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../widget/song_card.dart';

class SongsPage extends StatefulWidget {
  const SongsPage({required this.songs, Key? key}) : super(key: key);

  final List<SongInfo> songs;

  static _SongsPageState of(BuildContext context) =>
      context.findAncestorStateOfType<_SongsPageState>()!;

  @override
  State<SongsPage> createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
  late final List<SongInfo> songs;

  @override
  void initState() {
    songs = widget.songs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: songs.length,
          itemBuilder: (context, index) =>
              SongCard(songIndex: index, song: songs[index]),
        ),
      );
}
