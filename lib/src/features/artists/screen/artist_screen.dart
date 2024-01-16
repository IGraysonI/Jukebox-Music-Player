import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jukebox_music_player/src/common/widgets/basic/custom_sliver_app_bar.dart';
import 'package:jukebox_music_player/src/features/artists/widget/artist_card.dart';
import 'package:jukebox_music_player/src/features/audio_query/scope/audio_query_scope.dart';
import 'package:jukebox_music_player/src/features/jukebox_music_player/enum/navigation_tabs_enum.dart';
import 'package:octopus/octopus.dart';

/// {@template artists_tab}
/// ArtistsTab widget.
/// {@endtemplate}
class ArtistsTab extends StatelessWidget {
  /// {@macro artists_tab}
  const ArtistsTab({super.key});

  @override
  Widget build(BuildContext context) => BucketNavigator(
        bucket: '${NavigationTabsEnum.artists}-tab',
      );
}

/// {@template artists_tab}
/// ArtistsTab widget.
/// {@endtemplate}
class ArtistsScreen extends StatefulWidget {
  /// {@macro artists_tab}
  const ArtistsScreen({super.key});

  @override
  State<ArtistsScreen> createState() => _ArtistsScreenState();
}

class _ArtistsScreenState extends State<ArtistsScreen> {
  @override
  Widget build(BuildContext context) {
    final artists = AudioQueryScope.getArtists(context);
    if (artists.isEmpty) return const Center(child: CircularProgressIndicator());
    return CustomScrollView(
      slivers: [
        const CustomSliverAppBar(title: 'Artists'),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: AlignedGridView.count(
              itemCount: artists.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              itemBuilder: (context, index) => ArtistCard(artist: artists[index].artist),
            ),
          ),
        ),
        // ),
      ],
    );
  }
}
