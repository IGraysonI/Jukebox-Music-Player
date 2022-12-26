import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../widget/artist_card.dart';

class ArtistsPage extends StatelessWidget {
  const ArtistsPage({required this.artists, Key? key}) : super(key: key);

  final List<ArtistInfo> artists;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
      child: AlignedGridView.count(
        crossAxisCount: 2,
        itemBuilder: (context, index) => ArtistCard(artist: artists[index]),
      ),
    );
  }
}
