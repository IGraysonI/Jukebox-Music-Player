import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:go_router/go_router.dart';

import '../page/selected_artist_page.dart';

class ArtistCard extends StatelessWidget {
  const ArtistCard({required this.artist, super.key});

  final ArtistInfo artist;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () =>
            context.pushNamed(SelectedArtistPage.page(), extra: artist),
        child: Card(
          elevation: 8,
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: artist.artistArtPath == null
                    ? Image.asset(
                        'assets/images/no_image.jpg',
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        File(artist.artistArtPath!),
                        fit: BoxFit.cover,
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  artist.name!,
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
