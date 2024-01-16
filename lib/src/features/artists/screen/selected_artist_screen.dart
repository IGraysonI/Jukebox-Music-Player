import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/common/widgets/basic/space.dart';
import 'package:jukebox_music_player/src/features/albums/widget/albums_widget.dart';
import 'package:jukebox_music_player/src/features/audio_query/scope/audio_query_scope.dart';

class SelectedArtistScreen extends StatelessWidget {
  const SelectedArtistScreen({required this.id, super.key});

  final ArtistID? id;

  @override
  Widget build(BuildContext context) {
    final artistContent = AudioQueryScope.getArtistById(context, id!);
    if (artistContent == null) return const Center(child: CircularProgressIndicator());
    final artist = artistContent.artist;
    final albums = artistContent.albums;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: artist.artistArtPath == null ? null : MediaQuery.of(context).size.height * 0.55,
          flexibleSpace: FlexibleSpaceBar(
            background: artist.artistArtPath == null
                ? const SizedBox.shrink()
                : Image.file(
                    File(artist.artistArtPath!),
                    height: MediaQuery.of(context).size.height * 0.55,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
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
                  artist.name ?? 'Unknown Artist',
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
        AlbumsWidget(
          albumContents: albums,
        ),
        SliverToBoxAdapter(child: Space.xxxl()),
      ],
    );
  }
}
