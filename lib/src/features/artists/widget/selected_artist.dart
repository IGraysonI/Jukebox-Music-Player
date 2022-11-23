import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../common/widgets/space.dart';
import '../../albums/page/albums_page.dart';
import '../../albums/widget/album_card.dart';

class SelectedArtist extends StatelessWidget {
  const SelectedArtist({required this.artist, required this.albums, Key? key})
      : super(key: key);

  final ArtistInfo artist;
  final List<AlbumInfo> albums;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        children: [
          if (artist.artistArtPath == null)
            const SizedBox.shrink()
          else
            Image.file(
              File(artist.artistArtPath!),
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
          Space.sm(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                artist.name!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Space.sm(),
            ],
          ),
          AlbumsPage(albums: albums, isScrollable: false)
        ],
      ),
    );
  }
}
