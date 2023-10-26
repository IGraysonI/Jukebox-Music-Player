import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../../../common/widgets/space.dart';
import '../../songs/widget/song_card.dart';

class SelectedAlbum extends StatelessWidget {
  const SelectedAlbum({required this.album, required this.songs, super.key});

  final AlbumInfo album;
  final List<SongInfo> songs;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        children: [
          if (album.albumArt == null)
            const SizedBox.shrink()
          else
            Image.file(
              File(album.albumArt!),
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
          Space.sm(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  album.title!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Space.sm(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(album.artist!),
                        Text('${album.numberOfSongs!} songs'),
                      ],
                    ),
                    const Icon(Icons.more_vert),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: songs.length,
              itemBuilder: (context, index) => SongCard(
                song: songs[index],
                songIndex: index,
                showArtist: false,
                showArtwork: false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
