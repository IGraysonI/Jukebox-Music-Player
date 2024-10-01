import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/common/router/routes.dart';
import 'package:jukebox_music_player/src/common/widgets/basic/not_found_screen.dart';
import 'package:jukebox_music_player/src/common/widgets/basic/scaffold_padding.dart';
import 'package:jukebox_music_player/src/common/widgets/button/common_actions.dart';
import 'package:jukebox_music_player/src/features/albums/widget/album_list_tile.dart';
import 'package:jukebox_music_player/src/features/audio_query/scope/audio_query_scope.dart';
import 'package:jukevault/jukevault.dart';
import 'package:octopus/octopus.dart';

/// {@template album_screen}
/// ArtistScreen widget.
/// {@endtemplate}
class ArtistScreen extends StatefulWidget {
  /// {@macro artist_screen}
  const ArtistScreen({
    required this.id,
    super.key,
  });

  final String? id;

  @override
  State<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  void onTap(AlbumModel album) => context.octopus.setState((state) => state
    ..findByName('artists-tab')?.add(
      Routes.album.node(
        arguments: {'id': album.id.toString()},
      ),
    )
    ..arguments['bottomNavigation'] = 'artists');

  @override
  Widget build(BuildContext context) {
    if (widget.id == null) return const NotFoundScreen();
    final artistContent = AudioQueryScope.getArtistById(context, widget.id!);
    if (artistContent == null) return const NotFoundScreen();
    final artist = artistContent.artist;
    final albums = artistContent.albums;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            title: Text(artist.artist),
            actions: CommonActions(),
          ),

          // --- Image and title --- //
          SliverPadding(
            padding: ScaffoldPadding.of(context).copyWith(bottom: 8),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Image --- //
                  SizedBox.square(
                    dimension: 200,
                    child: Material(
                      color: Colors.transparent,
                      child: Hero(
                        tag: 'artist-${artist.id}-image',
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(16),
                            // image: artist.artistArtPath == null
                            //     ? const DecorationImage(
                            //         image: AssetImage('assets/images/no_image.jpg'),
                            //         fit: BoxFit.cover,
                            //         alignment: Alignment.center,
                            //       )
                            //     : DecorationImage(
                            //         image: FileImage(File(artist.artistArtPath!)),
                            //         fit: BoxFit.cover,
                            //         alignment: Alignment.center,
                            //       ),
                          ),
                          child: const SizedBox.expand(),
                        ),
                      ),
                    ),
                  ),

                  // --- Title --- //
                  Expanded(
                    child: SizedBox.square(
                      dimension: 200,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              artist.artist,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (artist.numberOfAlbums != null) Text('${artist.numberOfAlbums!} albums'),
                                    Text('${artist.numberOfTracks!} songs'),
                                  ],
                                ),
                                const Icon(Icons.more_vert),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // TODO: ? add play and shuffle buttons
          SliverPadding(
            padding: ScaffoldPadding.of(context).copyWith(left: 8, right: 8),
            sliver: const SliverToBoxAdapter(
              child: Divider(),
            ),
          ),

          // --- Albums --- //
          AlbumsListView(
            albums: albums,
            onTap: onTap,
          ),
        ],
      ),
    );
  }
}
