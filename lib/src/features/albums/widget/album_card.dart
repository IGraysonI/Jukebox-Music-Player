import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:go_router/go_router.dart';

import 'package:jukebox_music_player/src/features/albums/page/selected_album_page.dart';

class AlbumCard extends StatelessWidget {
  const AlbumCard({required this.album, super.key});

  final AlbumInfo album;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => context.pushNamed(SelectedAlbumPage.page(), extra: album),
        child: Card(
          elevation: 8,
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: album.albumArt == null
                    ? Image.asset(
                        'assets/images/no_image.jpg',
                        fit: BoxFit.cover,
                      )
                    : Image.file(File(album.albumArt!), fit: BoxFit.cover),
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
                            album.title!,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(album.artist!),
                        ],
                      ),
                    ),
                  ),
                  const Icon(Icons.more_vert),
                ],
              ),
            ],
          ),
        ),
      );
}
