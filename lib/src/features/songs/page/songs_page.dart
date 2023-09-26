import 'package:flutter/material.dart';

import '../../audio_query/scope/audio_query_root_scope.dart';
import '../widget/song_card.dart';

class SongsPage extends StatelessWidget {
  const SongsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final songs =
        AudioQueryRooyScope.stateOf(context)!.audioQueryBloc.state.songs;
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: songs.length,
        itemBuilder: (context, index) => SongCard(
          songIndex: index,
          song: songs[index],
        ),
      ),
    );
  }
}
