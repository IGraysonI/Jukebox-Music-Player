import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../widget/album_card.dart';

class AlbumsPage extends StatelessWidget {
  const AlbumsPage({required this.albums, required this.isScrollable, Key? key})
      : super(key: key);

  final List<AlbumInfo> albums;
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: AlignedGridView.count(
        physics: isScrollable ? null : const NeverScrollableScrollPhysics(),
        itemCount: albums.length,
        shrinkWrap: true,
        crossAxisCount: 2,
        itemBuilder: (context, index) => AlbumCard(album: albums[index]),
      ),
    );
  }
}
