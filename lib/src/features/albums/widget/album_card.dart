import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jukebox_music_player/src/features/albums/page/selected_album_page.dart';
import 'package:jukevault/jukevault.dart';

class AlbumCard extends StatelessWidget {
  const AlbumCard({required this.album, super.key});

  final AlbumModel album;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => context.pushNamed(SelectedAlbumPage.page(), extra: album),
        child: Card(
          elevation: 8,
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: QueryArtworkWidget(
                  id: album.id,
                  type: ArtworkType.ALBUM,
                ),
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
                            album.album,
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
