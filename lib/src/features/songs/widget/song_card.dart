import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../../music_player/pages/music_player.dart';

class SongCard extends StatelessWidget {
  const SongCard({
    required this.song,
    this.showArtist = true,
    this.showArtwork = true,
    this.index,
    Key? key,
  }) : super(key: key);

  final SongInfo song;
  final bool? showArtwork;
  final bool? showArtist;
  final int? index;

  String _getDuration(String value) {
    final doubleDuration = double.parse(value);
    final duration = Duration(milliseconds: doubleDuration.round());
    return '''${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}''';
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: showArtist!
          ? Image(
              image: FileImage(
                File(song.albumArtwork!),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(index.toString()),
                ],
              ),
            ),
      title: Text(song.title!),
      subtitle: Row(
        children: [
          if (showArtist!)
            Flexible(
              child: Text(
                song.artist!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          if (showArtist!) const Text(' • '),
          Text(_getDuration(song.duration!)),
        ],
      ),
      trailing: const Icon(Icons.more_vert_rounded, color: Colors.black),
      onTap: () => Navigator.push<Object>(
        context,
        MaterialPageRoute(builder: (context) => MusicPlayer(song: song)),
      ),
      dense: false,
    );
  }
}
