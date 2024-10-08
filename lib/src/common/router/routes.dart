import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/features/albums/widget/album_screen.dart';
import 'package:jukebox_music_player/src/features/albums/widget/albums_screen.dart';
import 'package:jukebox_music_player/src/features/artists/widget/artist_screen.dart';
import 'package:jukebox_music_player/src/features/artists/widget/artists_screen.dart';
import 'package:jukebox_music_player/src/features/developer/widget/developer_screen.dart';
import 'package:jukebox_music_player/src/features/jukebox_music_player/widget/bottom_navigation_screen.dart';
import 'package:jukebox_music_player/src/features/settings/widget/setting_screen.dart';
import 'package:jukebox_music_player/src/features/songs/widget/songs_screen.dart';
import 'package:octopus/octopus.dart';

enum Routes with OctopusRoute {
  bottomNavigation('bottomNavigation', title: 'Bottom Navigation'),
  songs('songs', title: 'Songs'),
  albums('albums', title: 'Albums'),
  album('album', title: 'Album'),
  artists('artists', title: 'Artists'),
  artist('artist', title: 'Artist'),
  settings('settings', title: 'Settings'),
  developer('developer', title: 'Developer');

  const Routes(this.name, {this.title});

  @override
  final String name;

  @override
  final String? title;

  @override
  Widget builder(BuildContext context, OctopusState state, OctopusNode node) => switch (this) {
        Routes.bottomNavigation => const BottomNavigationScreen(),
        Routes.songs => const SongsScreen(),
        Routes.albums => const AlbumsScreen(),
        Routes.album => AlbumScreen(id: node.arguments['id']),
        Routes.artists => const ArtistsScreen(),
        Routes.artist => ArtistScreen(id: node.arguments['id']),
        Routes.settings => const SettingScreen(),
        Routes.developer => const DeveloperScreen(),
      };
}
