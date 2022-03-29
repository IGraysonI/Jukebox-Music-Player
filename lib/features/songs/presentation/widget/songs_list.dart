import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:jukebox_music_player/screens/music_player.dart';

class SongsList extends StatelessWidget {
  final List<SongInfo> songs;
  final Function changeTrack;
  final GlobalKey<MusicPlayerState> musicPlayerKey;

  const SongsList(
      {Key? key,
      required this.songs,
      required this.changeTrack,
      required this.musicPlayerKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: songs.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(songs[index].title!),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MusicPlayer(
                  song: songs[index],
                  changeTrack: changeTrack,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
