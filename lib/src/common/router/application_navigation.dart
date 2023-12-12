import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:go_router/go_router.dart';

import 'package:jukebox_music_player/src/features/albums/page/albums_page.dart';
import 'package:jukebox_music_player/src/features/albums/page/selected_album_page.dart';
import 'package:jukebox_music_player/src/features/artists/page/artist_page.dart';
import 'package:jukebox_music_player/src/features/artists/page/selected_artist_page.dart';
import 'package:jukebox_music_player/src/features/jukebox_music_player/pages/bottom_navigation_page.dart';
import 'package:jukebox_music_player/src/features/settings/page/setting_page.dart';
import 'package:jukebox_music_player/src/features/songs/page/song_page.dart';
import 'package:jukebox_music_player/src/common/router/application_navigation_observer.dart';

class ApplicationNavigation {
  factory ApplicationNavigation() => _instance;

  ApplicationNavigation._internal() {
    final routes = [
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: parentNavigatorKey,
        branches: [
          StatefulShellBranch(
            navigatorKey: songsTabNavigatorKey,
            routes: [
              GoRoute(
                name: SongsPage.page(),
                path: '/${SongsPage.page()}',
                pageBuilder: (context, GoRouterState state) =>
                    getPage(child: const SongsPage(), state: state),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: albumsTabNavigatorKey,
            routes: [
              GoRoute(
                name: AlbumsPage.page(),
                path: '/${AlbumsPage.page()}',
                pageBuilder: (context, state) =>
                    getPage(child: const AlbumsPage(), state: state),
              ),
              GoRoute(
                name: SelectedAlbumPage.page(),
                path: '/${SelectedAlbumPage.page()}',
                pageBuilder: (context, state) => getPage(
                  child: SelectedAlbumPage(album: state.extra! as AlbumInfo),
                  state: state,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: artistsTabNavigatorKey,
            routes: [
              GoRoute(
                name: ArtistsPage.page(),
                path: '/${ArtistsPage.page()}',
                pageBuilder: (context, state) =>
                    getPage(child: const ArtistsPage(), state: state),
              ),
              GoRoute(
                name: SelectedArtistPage.page(),
                path: '/${SelectedArtistPage.page()}',
                pageBuilder: (context, state) => getPage(
                  child: SelectedArtistPage(
                    artist: state.extra! as ArtistInfo,
                  ),
                  state: state,
                ),
              ),
            ],
          ),
        ],
        pageBuilder: (context, state, navigationShell) => getPage(
          child: BottomNavigationPage(child: navigationShell),
          state: state,
        ),
      ),
      GoRoute(
        path: SettingPage.page(),
        name: SettingPage.page(),
        pageBuilder: (context, state) => getPage(
          child: const SettingPage(),
          state: state,
        ),
      ),
    ];

    router = GoRouter(
      navigatorKey: parentNavigatorKey,
      initialLocation: '/${SongsPage.page()}',
      observers: [ApplicationNavigationObserver()],
      routes: routes,
    );
  }

  static final ApplicationNavigation _instance =
      ApplicationNavigation._internal();

  static ApplicationNavigation get instance => _instance;

  static late final GoRouter router;

  static final GlobalKey<NavigatorState> parentNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> songsTabNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> albumsTabNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> artistsTabNavigatorKey =
      GlobalKey<NavigatorState>();

  BuildContext get context =>
      router.routerDelegate.navigatorKey.currentContext!;

  GoRouterDelegate get routerDelegate => router.routerDelegate;

  GoRouteInformationParser get routeInformationParser =>
      router.routeInformationParser;

  static Page<Widget> getPage({
    required Widget child,
    required GoRouterState state,
  }) =>
      MaterialPage(key: state.pageKey, child: child);
}
