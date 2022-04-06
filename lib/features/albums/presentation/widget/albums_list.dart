import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jukebox_music_player/features/albums/presentation/screen/selected_album_screen.dart';

class AlbumList extends StatelessWidget {
  final List<AlbumInfo> albums;

  const AlbumList({
    Key? key,
    required this.albums,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlignedGridView.count(
      crossAxisCount: 2,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SelectedAlbumScreen(albumInfo: albums[index]))),
          child: Card(
            child: Column(
              children: [
                Image.file(
                  File(albums[index].albumArt!),
                  fit: BoxFit.cover,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              albums[index].title!,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(albums[index].artist!),
                          ],
                        ),
                      ),
                    ),
                    Icon(Icons.more_vert)
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
    // GridView.builder(
    //   gridDelegate:
    //       SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    //   itemCount: albums.length,
    //   itemBuilder: (context, index) {
    //     return Card(
    //       child: Column(
    //         children: [
    //           Image.file(
    //             File(albums[index].albumArt!),
    //             fit: BoxFit.cover,
    //           ),
    //           Text('data')
    //         ],
    //       ),
    //     );
    //   },
    // );
  }
}
