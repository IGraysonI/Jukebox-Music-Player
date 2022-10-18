import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../widget/song_card.dart';

class SongsPage extends StatelessWidget {
  const SongsPage({required this.songs, required this.isScrollable, Key? key})
      : super(key: key);

  final List<SongInfo> songs;
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
        shrinkWrap: true,
        physics: isScrollable ? null : const NeverScrollableScrollPhysics(),
        itemCount: songs.length,
        itemBuilder: (context, index) => SongCard(song: songs[index]),
      ),
    );
  }
}
