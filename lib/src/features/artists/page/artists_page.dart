import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../widget/artist_card.dart';

class ArtistsPage extends StatelessWidget {
  const ArtistsPage({required this.artists, Key? key}) : super(key: key);

  final List<ArtistInfo> artists;

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          child: AlignedGridView.count(
            itemCount: artists.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            itemBuilder: (context, index) => ArtistCard(artist: artists[index]),
          ),
        ),
      );
}
