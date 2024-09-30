import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jukebox_music_player/src/features/artists/page/selected_artist_page.dart';
import 'package:jukevault/jukevault.dart';

class ArtistCard extends StatelessWidget {
  const ArtistCard({required this.artist, super.key});

  final ArtistModel artist;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => context.pushNamed(SelectedArtistPage.page(), extra: artist),
        child: Card(
          elevation: 8,
          child: Column(
            children: [
              SizedBox(
                  height: 100,
                  child: QueryArtworkWidget(
                    id: artist.id,
                    type: ArtworkType.ARTIST,
                  )
                  // artist.artistArtPath == null
                  //     ? Image.asset(
                  //         'assets/images/no_image.jpg',
                  //         fit: BoxFit.cover,
                  //       )
                  //     : Image.file(
                  //         File(artist.artistArtPath!),
                  //         fit: BoxFit.cover,
                  //       ),
                  ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  artist.artist,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
