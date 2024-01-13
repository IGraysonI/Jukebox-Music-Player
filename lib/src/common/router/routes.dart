import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:jukebox_music_player/src/features/albums/screen/albums_screen.dart';
import 'package:jukebox_music_player/src/features/albums/screen/selected_album_screen.dart';
import 'package:jukebox_music_player/src/features/artists/screen/artist_screen.dart';
import 'package:jukebox_music_player/src/features/artists/screen/selected_artist_screen.dart';
import 'package:jukebox_music_player/src/features/jukebox_music_player/widget/bottom_navigation_screen.dart';
import 'package:jukebox_music_player/src/features/settings/page/setting_page.dart';
import 'package:jukebox_music_player/src/features/songs/screen/song_screen.dart';
import 'package:octopus/octopus.dart';

enum Routes with OctopusRoute {
  bottomNavigation('bottomNavigation', title: 'Bottom Navigation'),
  songs('songs', title: 'Songs'),
  albums('albums', title: 'Albums'),
  selectedAlbum('selectedAlbum', title: 'Selected Album'),
  artists('artists', title: 'Artists'),
  selectedArtist('selectedArtist', title: 'Selected Artist'),
  settings('settings', title: 'Settings');

  const Routes(this.name, {this.title});

  @override
  final String name;

  @override
  final String? title;

  @override
  Widget builder(BuildContext context, OctopusState state, OctopusNode node) =>
      switch (this) {
        Routes.bottomNavigation => const BottomNavigationScreen(),
        Routes.songs => const SongsScreen(),
        Routes.albums => const AlbumsScreen(),
        Routes.selectedAlbum =>
          //FIXME: Find efficient way to pass extra data to page.
          SelectedAlbumScreen(album: node.extra['album'] as AlbumInfo),
        Routes.artists => const ArtistsScreen(),
        Routes.selectedArtist =>
          SelectedArtistScreen(artist: node.extra['artist'] as ArtistInfo),
        Routes.settings => const SettingPage(),
      };
}
