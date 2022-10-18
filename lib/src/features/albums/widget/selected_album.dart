import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../../songs/widget/songs_list.dart';

class SelectedAlbum extends StatelessWidget {
  const SelectedAlbum({required this.albumInfo, required this.songs, Key? key})
      : super(key: key);

  final AlbumInfo albumInfo;
  final List<SongInfo> songs;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        children: [
          Image.file(
            File(albumInfo.albumArt!),
            height: MediaQuery.of(context).size.height * 0.55,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(albumInfo.title!),
                    Text(albumInfo.numberOfSongs!),
                  ],
                ),
                const Icon(Icons.more_vert),
              ],
            ),
          ),
          SongsList(
            songs: songs,
            isScrollable: false,
          ),
        ],
      ),
    );
  }
}
