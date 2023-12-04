import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../common/controller/state_consumer.dart';
import '../../audio_query/controller/audio_query_controller.dart';
import '../../audio_query/controller/audio_query_state.dart';
import '../../audio_query/scope/audio_query_scope.dart';
import '../widget/artist_card.dart';

class ArtistsPage extends StatefulWidget {
  const ArtistsPage({super.key});

  static String page() => 'ArtistsPage';

  @override
  State<ArtistsPage> createState() => _ArtistsPageState();
}

class _ArtistsPageState extends State<ArtistsPage> {
  late final AudioQueryController _audioQueryController;

  @override
  void initState() {
    super.initState();
    _audioQueryController = AudioQueryScope.controllerOf(context);
  }

  @override
  void dispose() {
    _audioQueryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('Artists'),
            floating: true,
            snap: true,
          ),
          StateConsumer<AudioQueryState>(
            controller: _audioQueryController,
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
