import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'album_card.dart';

class AlbumsWidget extends StatelessWidget {
  const AlbumsWidget({this.albums, super.key});

  final List<AlbumInfo>? albums;

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          child: AlignedGridView.count(
            physics: const NeverScrollableScrollPhysics(),
            // itemCount: albums?.length ?? state.albums.length,
            itemCount: 2,
            shrinkWrap: true,
            crossAxisCount: 2,
            itemBuilder: (context, index) => AlbumCard(
              // album: albums?[index] ?? state.albums[index],
              album: albums![index],
            ),
          ),
        ),
      );
}
