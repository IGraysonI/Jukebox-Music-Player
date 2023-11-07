import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../../albums/widget/albums_widget.dart';

class SelectedArtist extends StatelessWidget {
  const SelectedArtist({required this.artist, required this.albums, super.key});

  final ArtistInfo artist;
  final List<AlbumInfo> albums;

  @override
  Widget build(BuildContext context) => CustomScrollView(
        // physics: const ScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.3,
            flexibleSpace: FlexibleSpaceBar(
              background: artist.artistArtPath == null
                  ? const SizedBox.shrink()
                  : Image.file(
                      File(artist.artistArtPath!),
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                    ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            floating: true,
            snap: true,
          ),
          AlbumsWidget(albums: albums),
        ],
      );
}
