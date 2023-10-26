import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../audio_query/bloc/audio_query_bloc.dart';
import '../../audio_query/scope/audio_query_root_scope.dart';
import '../widget/artist_card.dart';

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
          const SliverAppBar(
            title: Text('Artists'),
            floating: true,
            snap: true,
          ),
          BlocBuilder<AudioQueryBloc, AudioQueryState>(
            bloc: AudioQueryRooyScope.of(context).audioQueryBloc,
            builder: (context, state) => SliverToBoxAdapter(
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
