import 'package:control/control.dart';
import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/common/model/dependencies.dart';
import 'package:jukebox_music_player/src/common/router/routes.dart';
import 'package:jukebox_music_player/src/common/widgets/basic/application_sliver_app_bar.dart';
import 'package:jukebox_music_player/src/common/widgets/basic/space.dart';
import 'package:jukebox_music_player/src/features/audio_query/controller/audio_query_controller.dart';
import 'package:jukebox_music_player/src/features/audio_query/controller/audio_query_state.dart';
import 'package:jukebox_music_player/src/features/audio_query/scope/audio_query_scope.dart';
import 'package:jukebox_music_player/src/features/jukebox_music_player/enum/navigation_tabs_enum.dart';
import 'package:jukevault/jukevault.dart';
import 'package:octopus/octopus.dart';

enum _Artistiew {
  grid('Grid'),
  list('List');

  const _Artistiew(this.name);

  final String name;
}

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

/// {@template artists_screen}
/// ArtistsScreen widget.
/// {@endtemplate}
class ArtistsScreen extends StatefulWidget {
  /// {@macro artists_screen}
  const ArtistsScreen({super.key});

  @override
  State<ArtistsScreen> createState() => _ArtistsScreenState();
}

class _ArtistsScreenState extends State<ArtistsScreen> {
  late final AudioQueryController _audioQueryController;
  _Artistiew _artistsView = _Artistiew.grid;

  @override
  void initState() {
    super.initState();
    _audioQueryController = Dependencies.of(context).audioQueryController;
  }

  void onTap(ArtistModel artist) => context.octopus.setState((state) => state
    ..findByName('artists-tab')?.add(
      Routes.artist.node(
        arguments: {'id': artist.id.toString()},
      ),
    )
    ..arguments['bottomNavigation'] = 'artists');

  void _showSnakBar(SnackBar snackBar) => ScaffoldMessenger.maybeOf(context)
    ?..clearSnackBars()
    ..showSnackBar(snackBar);

  void _onStateChanged(
    BuildContext context,
    AudioQueryController controller,
    AudioQueryState previousState,
    AudioQueryState nextState,
  ) {
    switch (nextState) {
      case AudioQueryState$Successful state:
        _showSnakBar(
          SnackBar(
            content: Text('Successfully loaded ${state.songs.length} songs}'),
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.green,
          ),
        );
      case AudioQueryState$Error state:
        _showSnakBar(
          SnackBar(
            content: Text('Error: ${state.message}'),
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.red,
          ),
        );
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final artists = AudioQueryScope.getArtists(context);
    if (artists.isEmpty) return const Center(child: CircularProgressIndicator());
    return StateConsumer<AudioQueryController, AudioQueryState>(
      controller: _audioQueryController,
      listener: _onStateChanged,
      builder: (context, state, child) => CustomScrollView(
        slivers: [
          ApplicationSliverAppBar(
            title: 'Artists',
            expandedHeight: 128,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.fromLTRB(16, 48, 16, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 128,
                      height: 48,
                      child: ToggleButtons(
                        isSelected: <bool>[
                          _artistsView == _Artistiew.grid,
                          _artistsView == _Artistiew.list,
                        ],
                        children: const [
                          Icon(Icons.grid_view),
                          Icon(Icons.list),
                        ],
                        onPressed: (index) => setState(() => _artistsView = _Artistiew.values[index]),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          switch (_artistsView) {
            _Artistiew.grid => _ArtistGridView(artists),
            _Artistiew.list => _ArtistsListView(artists),
          }
        ],
      ),
    );
  }
}

class _ArtistsListView extends StatelessWidget {
  const _ArtistsListView(this.artists);

  final List<ArtistContent> artists;

  @override
  Widget build(BuildContext context) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => _ArtistsListTile(artist: artists[index].artist),
          childCount: artists.length,
        ),
      );
}

class _ArtistsListTile extends StatelessWidget {
  const _ArtistsListTile({required this.artist});

  final ArtistModel artist;

  @override
  Widget build(BuildContext context) => ListTile(
        dense: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        leading: AspectRatio(
          aspectRatio: 1,
          child: Ink(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: _ArtistCardImage(artist: artist),
          ),
        ),
        title: Text(
          artist.artist,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          artist.numberOfTracks != null ? '${artist.numberOfTracks} songs' : 'Unknown number of songs',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16,
            height: 0.9,
            letterSpacing: -0.3,
            fontWeight: FontWeight.w400,
          ),
        ),
        onTap: () => context.findAncestorStateOfType<_ArtistsScreenState>()?.onTap(artist),
      );
}

class _ArtistGridView extends StatelessWidget {
  const _ArtistGridView(this.artists);

  final List<ArtistContent> artists;

  @override
  Widget build(BuildContext context) => SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 256,
          childAspectRatio: 256 / 290,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: artists.length,
        itemBuilder: (context, index) => _ArtistGridTile(
          artist: artists[index].artist,
        ),
      );
}

class _ArtistGridTile extends StatelessWidget {
  const _ArtistGridTile({required this.artist});

  final ArtistModel artist;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => context.findAncestorStateOfType<_ArtistsScreenState>()?.onTap(artist),
        child: Card(
            clipBehavior: Clip.antiAlias,
            color: Theme.of(context).cardColor,
            margin: const EdgeInsets.all(4),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                // Content
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Center(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Center(
                                child: _ArtistCardImage(artist: artist),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 45,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Align(
                            alignment: const Alignment(0, -5),
                            child: Column(
                              children: [
                                Text(
                                  artist.artist,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    height: .9,
                                    letterSpacing: -.3,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Space.xs(),
                                Text(
                                  artist.numberOfTracks != null
                                      ? '${artist.numberOfTracks} songs'
                                      : 'Unknown number of songs',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    height: .9,
                                    letterSpacing: -.3,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// Tap area
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      hoverColor: Theme.of(context).hoverColor,
                      splashColor: Theme.of(context).splashColor,
                      highlightColor: Theme.of(context).highlightColor,
                      onTap: () => context.findAncestorStateOfType<_ArtistsScreenState>()?.onTap(artist),
                    ),
                  ),
                ),
              ],
            )),
      );
}

class _ArtistCardImage extends StatelessWidget {
  const _ArtistCardImage({required this.artist});

  final ArtistModel artist;

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: Hero(
          tag: 'artist-${artist.id}-image',
          //TODO: Change to circle image(Do not use fucking CircleAvatar shit)
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
      );
}
