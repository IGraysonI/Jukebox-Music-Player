import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:jukebox_music_player/features/songs/presentation/widget/songs_list.dart';

class SelectedAlbum extends StatelessWidget {
  final AlbumInfo albumInfo;
  final List<SongInfo> songs;
  const SelectedAlbum({Key? key, required this.albumInfo, required this.songs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: [
          Image.file(
            File(albumInfo.albumArt!),
            height: MediaQuery.of(context).size.height * 0.55,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(albumInfo.title!),
                    Text(albumInfo.numberOfSongs!),
                  ],
                ),
                Icon(Icons.more_vert),
              ],
            ),
          ),
          SongsList(
            songs: songs,
            shrinkWrap: true,
            isScrollable: false,
          ),
        ],
      ),
    );
  }
}
