import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:jukebox_music_player/src/common/controller/state_consumer.dart';
import 'package:jukebox_music_player/src/common/widgets/custom_sliver_app_bar.dart';
import 'package:jukebox_music_player/src/features/audio_query/controller/audio_query_state.dart';
import 'package:jukebox_music_player/src/features/audio_query/scope/audio_query_scope.dart';
import 'package:jukebox_music_player/src/features/artists/widget/artist_card.dart';

class ArtistsPage extends StatefulWidget {
  const ArtistsPage({super.key});

  static String page() => 'ArtistsPage';

  @override
  State<ArtistsPage> createState() => _ArtistsPageState();
}

class _ArtistsPageState extends State<ArtistsPage> {
  @override
  Widget build(BuildContext context) => CustomScrollView(
        slivers: [
          const CustomSliverAppBar(title: 'Artists'),
          StateConsumer<AudioQueryState>(
            controller: AudioQueryScope.controllerOf(context),
            builder: (context, state, _) => SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: AlignedGridView.count(
                  itemCount: state.artists.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  itemBuilder: (context, index) =>
                      ArtistCard(artist: state.artists[index]),
                ),
              ),
            ),
          ),
        ],
      );
}
