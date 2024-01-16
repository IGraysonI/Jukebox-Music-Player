import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/common/util/player_util.dart';
import 'package:jukebox_music_player/src/features/albums/screen/albums_screen.dart';
import 'package:jukebox_music_player/src/features/artists/screen/artist_screen.dart';
import 'package:jukebox_music_player/src/features/jukebox_music_player/enum/navigation_tabs_enum.dart';
import 'package:jukebox_music_player/src/features/music_player/widgets/music_player.dart';
import 'package:jukebox_music_player/src/features/songs/screen/song_screen.dart';
import 'package:l/l.dart';
import 'package:octopus/octopus.dart';

/// {@template bottom_navigation_screen}
/// BottomNavigationScreen
/// {@endtemplate}
class BottomNavigationScreen extends StatefulWidget {
  /// {@macro bottom_navigation_screen}
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  // Octopus state observer
  late final OctopusStateObserver _octopusStateObserver;

  // Current tab
  NavigationTabsEnum _tab = NavigationTabsEnum.songs;

  @override
  void initState() {
    super.initState();
    _octopusStateObserver = context.octopus.observer;

    // Restore tab from router arguments.
    _tab = NavigationTabsEnum.fromValue(
      _octopusStateObserver.value.arguments['bottomNavigation'],
      fallback: NavigationTabsEnum.songs,
    );
    _octopusStateObserver.addListener(_onOctopusStateChanged);
  }

  @override
  void dispose() {
    _octopusStateObserver.removeListener(_onOctopusStateChanged);
    super.dispose();
  }

  // Change tab.
  void _switchTab(NavigationTabsEnum tab) {
    if (!mounted) return;
    if (_tab == tab) return;
    context.octopus.setArguments((args) => args['bottomNavigation'] = tab.name);
    setState(() => _tab = tab);
  }

  // Pop to albums at double tap on albums-tab.
  void _clearAlbumsNavigationStack() => context.octopus.setState(
        (state) {
          final albums = state.findByName('albums-tab');
          if (albums == null || albums.children.length < 2) return state;
          albums.children.length = 1;
          if (mounted) {
            l.i('Clear albums navigation stack');
          }
          return state;
        },
      );

  // Pop to artists at double tap on artists-tab.
  void _clearArtistsNavigationStack() => context.octopus.setState(
        (state) {
          final artists = state.findByName('artists-tab');
          if (artists == null || artists.children.length < 2) return state;
          artists.children.length = 1;
          if (mounted) {
            l.i('Clear artists navigation stack');
          }
          return state;
        },
      );

  // Bottom navigation bar item tapped.
  void _onItemTapped(int index) {
    final newTab = NavigationTabsEnum.values[index];
    if (_tab == newTab) {
      // The same tab tapped twice.
      if (newTab == NavigationTabsEnum.albums) _clearAlbumsNavigationStack();
      if (newTab == NavigationTabsEnum.artists) _clearArtistsNavigationStack();
    } else {
      // Switch tab to new one.
      _switchTab(newTab);
    }
  }

  // Router state changed.
  void _onOctopusStateChanged() {
    final newTab = NavigationTabsEnum.fromValue(
      _octopusStateObserver.value.arguments['bottomNavigation'],
      fallback: NavigationTabsEnum.songs,
    );
    _switchTab(newTab);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: playerExpandProgress,
          builder: (context, height, child) {
            final value = PlayerUtil.percentageFromValueInRange(
              max: MediaQuery.of(context).size.height,
              min: PlayerUtil.playerMinHeight,
              value: height,
            );
            final navigationBarHeight = const NavigationBarThemeData().height ?? 80;
            var opacity = 1 - value;
            if (opacity < 0) opacity = 0;
            if (opacity > 1) opacity = 1;

            return SizedBox(
              height: navigationBarHeight - navigationBarHeight * value,
              child: Transform.translate(
                offset: Offset(0, navigationBarHeight * value * 0.5),
                child: Opacity(
                  opacity: opacity,
                  child: OverflowBox(
                    maxHeight: navigationBarHeight,
                    child: child,
                  ),
                ),
              ),
            );
          },
          child: NavigationBar(
            selectedIndex: _tab.index,
            onDestinationSelected: _onItemTapped,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.audiotrack_rounded),
                label: 'Songs',
              ),
              NavigationDestination(
                icon: Icon(Icons.album_rounded),
                label: 'Albums',
              ),
              NavigationDestination(
                icon: Icon(Icons.account_circle_rounded),
                label: 'Artists',
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            IndexedStack(
              index: _tab.index,
              children: const [
                SongsTab(),
                AlbumsTab(),
                ArtistsTab(),
              ],
            ),
            const MusicPlayer(),
          ],
        ),
      );
}
