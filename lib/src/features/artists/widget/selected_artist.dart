import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/common/widgets/basic/space.dart';
import 'package:jukebox_music_player/src/features/albums/widget/albums_widget.dart';
import 'package:jukevault/jukevault.dart';

class SelectedArtist extends StatelessWidget {
  const SelectedArtist({required this.artist, required this.albums, super.key});

  final ArtistModel artist;
  final List<AlbumModel> albums;

  @override
  Widget build(BuildContext context) => CustomScrollView(
        slivers: [
          SliverAppBar(
            // expandedHeight: artist.artistArtPath == null
            //     ? null
            //     : MediaQuery.of(context).size.height * 0.55,
            expandedHeight: MediaQuery.of(context).size.height * 0.55,
            flexibleSpace: FlexibleSpaceBar(
                background: QueryArtworkWidget(
              id: artist.id,
              type: ArtworkType.ARTIST,
            )
                // artist.artistArtPath == null
                //     ? const SizedBox.shrink()
                //     : Image.file(
                //         File(artist.artistArtPath!),
                //         height: MediaQuery.of(context).size.height * 0.55,
                //         width: MediaQuery.of(context).size.width,
                //         fit: BoxFit.fill,
                //       ),
                ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          SliverToBoxAdapter(child: Space.sm()),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    artist.artist,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Space.sm(),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: Space.sm()),
          AlbumsWidget(albums: albums),
          SliverToBoxAdapter(child: Space.xxxl()),
        ],
      );
}
