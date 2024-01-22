import 'dart:io';

import 'package:control/control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:jukebox_music_player/src/common/model/dependencies.dart';
import 'package:jukebox_music_player/src/common/router/routes.dart';
import 'package:jukebox_music_player/src/common/widgets/basic/application_sliver_app_bar.dart';
import 'package:jukebox_music_player/src/common/widgets/basic/space.dart';
import 'package:jukebox_music_player/src/features/audio_query/controller/audio_query_controller.dart';
import 'package:jukebox_music_player/src/features/audio_query/controller/audio_query_state.dart';
import 'package:jukebox_music_player/src/features/audio_query/scope/audio_query_scope.dart';
import 'package:jukebox_music_player/src/features/jukebox_music_player/enum/navigation_tabs_enum.dart';
import 'package:octopus/octopus.dart';

/// {@template albums_tab}
/// AlbumsTab widget.
/// {@endtemplate}
class AlbumsTab extends StatelessWidget {
  /// {@macro albums_tab}
  const AlbumsTab({super.key});

  @override
  Widget build(BuildContext context) => BucketNavigator(
        bucket: '${NavigationTabsEnum.albums}-tab',
      );
}

/// {@template albums_screen}
/// AlbumsScreen widget.
/// {@endtemplate}
class AlbumsScreen extends StatefulWidget {
  /// {@macro albums_screen}
  const AlbumsScreen({super.key});

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  late final AudioQueryController _audioQueryController;

  @override
  void initState() {
    super.initState();
    _audioQueryController = Dependencies.of(context).audioQueryController;
  }

  void onTap(AlbumInfo album) => context.octopus.setState((state) => state
    ..findByName('albums-tab')?.add(
      Routes.selectedAlbum.node(
        arguments: {'id': album.id},
      ),
    )
    ..arguments['bottomNavigation'] = 'albums');

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
    final albums = AudioQueryScope.getAlbums(context);
    if (albums.isEmpty) return const Center(child: CircularProgressIndicator());
    return StateConsumer<AudioQueryController, AudioQueryState>(
      controller: _audioQueryController,
      listener: _onStateChanged,
      builder: (context, state, child) => CustomScrollView(
        slivers: [
          const ApplicationSliverAppBar(title: 'Albums'),
          SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 256,
              childAspectRatio: 256 / 290,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: albums.length,
            itemBuilder: (context, index) => _AlbumGridTile(
              album: albums[index].album,
            ),
          ),
        ],
      ),
    );
  }
}

class _AlbumGridTile extends StatelessWidget {
  const _AlbumGridTile({required this.album});

  final AlbumInfo album;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => context.findAncestorStateOfType<_AlbumsScreenState>()?.onTap(album),
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
                                child: _AlbumCardImage(album: album),
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
                                  album.title!,
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
                                  album.artist!,
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
                      onTap: () => context.findAncestorStateOfType<_AlbumsScreenState>()?.onTap(album),
                    ),
                  ),
                ),
              ],
            )),
      );
}

class _AlbumCardImage extends StatelessWidget {
  const _AlbumCardImage({required this.album});

  final AlbumInfo album;

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: Hero(
          tag: 'album-${album.id}-image',
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(16),
              image: album.albumArt == null
                  ? const DecorationImage(
                      image: AssetImage('assets/images/no_image.jpg'),
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    )
                  : DecorationImage(
                      image: FileImage(File(album.albumArt!)),
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
            ),
            child: const SizedBox.expand(),
          ),
        ),
      );
}
