import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/features/albums/screen/albums_screen.dart';
import 'package:jukebox_music_player/src/features/albums/screen/selected_album_screen.dart';
import 'package:jukebox_music_player/src/features/artists/screen/artist_screen.dart';
import 'package:jukebox_music_player/src/features/artists/screen/selected_artist_screen.dart';
import 'package:jukebox_music_player/src/features/developer/widget/developer_screen.dart';
import 'package:jukebox_music_player/src/features/jukebox_music_player/widget/bottom_navigation_screen.dart';
import 'package:jukebox_music_player/src/features/settings/widget/setting_screen.dart';
import 'package:jukebox_music_player/src/features/songs/screen/song_screen.dart';
import 'package:octopus/octopus.dart';

enum Routes with OctopusRoute {
  bottomNavigation('bottomNavigation', title: 'Bottom Navigation'),
  songs('songs', title: 'Songs'),
  albums('albums', title: 'Albums'),
  selectedAlbum('selectedAlbum', title: 'Selected Album'),
  artists('artists', title: 'Artists'),
  selectedArtist('selectedArtist', title: 'Selected Artist'),
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
        Routes.selectedAlbum => SelectedAlbumScreen(id: node.arguments['id']),
        Routes.artists => const ArtistsScreen(),
        Routes.selectedArtist => SelectedArtistScreen(id: node.arguments['id']),
        Routes.settings => const SettingScreen(),
        Routes.developer => const DeveloperScreen(),
      };
}
