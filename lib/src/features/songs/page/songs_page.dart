import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../widget/song_card.dart';

class SongsPage extends StatelessWidget {
  const SongsPage({required this.songs, Key? key}) : super(key: key);

  final List<SongInfo> songs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: songs.length,
        itemBuilder: (context, index) => SongCard(
          songIndex: index,
          songs: songs,
        ),
      ),
    );
  }
}
