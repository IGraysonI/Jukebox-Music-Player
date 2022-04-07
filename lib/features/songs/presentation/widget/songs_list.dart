import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:jukebox_music_player/screens/music_player.dart';

class SongsList extends StatelessWidget {
  final List<SongInfo> songs;
  final bool shrinkWrap;
  final bool isScrollable;

  const SongsList(
      {Key? key,
      required this.songs,
      required this.isScrollable,
      required this.shrinkWrap})
      : super(key: key);

  String _getDuration(String value) {
    final double doubleDuration = double.parse(value);
    Duration duration = Duration(milliseconds: doubleDuration.round());
    return "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: shrinkWrap,
      physics: isScrollable ? null : NeverScrollableScrollPhysics(),
      itemCount: songs.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: Image(
              image: FileImage(
                File(songs[index].albumArtwork!),
              ),
            ),
            title: Text(songs[index].title!),
            subtitle: Row(
              children: [
                Text(songs[index].artist!),
                Text(' • '),
                Text(_getDuration(songs[index].duration!)),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MusicPlayer(
                    songs: songs,
                    // changeTrack: changeTrack!,
                    songIndex: index,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
