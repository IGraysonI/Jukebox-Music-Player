import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AlbumList extends StatelessWidget {
  const AlbumList({required this.albums, Key? key}) : super(key: key);

  final List<AlbumInfo> albums;

  @override
  Widget build(BuildContext context) {
    return AlignedGridView.count(
      crossAxisCount: 2,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {},
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
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              albums[index].title!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(albums[index].artist!),
                          ],
                        ),
                      ),
                    ),
                    const Icon(Icons.more_vert)
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
