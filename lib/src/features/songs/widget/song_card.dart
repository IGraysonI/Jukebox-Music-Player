import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class SongCard extends StatelessWidget {
  const SongCard({required this.song, Key? key}) : super(key: key);

  final SongInfo song;

  String _getDuration(String value) {
    final doubleDuration = double.parse(value);
    final duration = Duration(milliseconds: doubleDuration.round());
    return '''${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}''';
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image(
        image: FileImage(
          File(song.albumArtwork!),
        ),
      ),
      title: Text(song.title!),
      subtitle: Row(
        children: [
          Text(song.artist!),
          const Text(' • '),
          Text(_getDuration(song.duration!)),
        ],
      ),
      trailing: const Icon(Icons.more_vert_rounded, color: Colors.black),
      onTap: () {},
      dense: false,
    );
  }
}
