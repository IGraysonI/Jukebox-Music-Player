import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../widget/album_card.dart';

class AlbumsPage extends StatelessWidget {
  const AlbumsPage({required this.albums, Key? key}) : super(key: key);

  final List<AlbumInfo> albums;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: AlignedGridView.count(
        crossAxisCount: 2,
        itemBuilder: (context, index) => AlbumCard(album: albums[index]),
      ),
    );
  }
}
