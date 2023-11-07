import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../../../common/widgets/space.dart';
import '../../albums/widget/albums_widget.dart';

class SelectedArtist extends StatelessWidget {
  const SelectedArtist({required this.artist, required this.albums, super.key});

  final ArtistInfo artist;
  final List<AlbumInfo> albums;

  @override
  Widget build(BuildContext context) => CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: artist.artistArtPath == null
                ? null
                : MediaQuery.of(context).size.height * 0.55,
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
          AlbumsWidget(albums: albums),
          SliverToBoxAdapter(child: Space.xxxl()),
        ],
      );
}
