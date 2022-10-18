import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class SongsList extends StatelessWidget {
  const SongsList({
    required this.songs,
    required this.isScrollable,
    Key? key,
  }) : super(key: key);

  final List<SongInfo> songs;
  final bool isScrollable;

  String _getDuration(String value) {
    final doubleDuration = double.parse(value);
    final duration = Duration(milliseconds: doubleDuration.round());
    return '''${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}''';
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: isScrollable ? null : const NeverScrollableScrollPhysics(),
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
                const Text(' • '),
                Text(_getDuration(songs[index].duration!)),
              ],
            ),
            onTap: () {},
          ),
        );
      },
    );
  }
}
