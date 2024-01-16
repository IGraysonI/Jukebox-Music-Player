import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:jukebox_music_player/src/common/router/routes.dart';
import 'package:octopus/octopus.dart';

class AlbumCard extends StatelessWidget {
  const AlbumCard({required this.album, required this.fromArtistScreen, super.key});

  final AlbumInfo album;
  final bool fromArtistScreen;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => context.octopus.setState((state) => state
          ..findByName(fromArtistScreen ? 'artists-tab' : 'albums-tab')?.add(
            Routes.selectedAlbum.node(
              arguments: {'id': album.id},
            ),
          )
          ..arguments['bottomNavigation'] = fromArtistScreen ? 'artists' : 'albums'),
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
