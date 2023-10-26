import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/albums/page/albums_page.dart';
import '../../features/artists/page/artists_page.dart';
import '../../features/jukebox_music_player/pages/bottom_navigation_page.dart';
import '../../features/songs/page/songs_page.dart';
import 'application_navigation_observer.dart';

class ApplicationNavigation {
  factory ApplicationNavigation() => _instance;

  ApplicationNavigation._internal() {
    final routes = [
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: parentNavigatorKey,
        branches: [
          StatefulShellBranch(
            navigatorKey: firstTabNavigatorKey,
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
            navigatorKey: secondTabNavigatorKey,
            routes: [
              GoRoute(
                name: AlbumsPage.page(),
                path: '/${AlbumsPage.page()}',
                pageBuilder: (context, state) =>
                    getPage(child: const AlbumsPage(), state: state),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: settingsTabNavigatorKey,
            routes: [
              GoRoute(
                name: ArtistsPage.page(),
                path: '/${ArtistsPage.page()}',
                pageBuilder: (context, state) =>
                    getPage(child: const ArtistsPage(), state: state),
              ),
            ],
          ),
        ],
        pageBuilder: (context, state, navigationShell) => getPage(
          child: BottomNavigationPage(child: navigationShell),
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
  static final GlobalKey<NavigatorState> firstTabNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> secondTabNavigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> settingsTabNavigatorKey =
      GlobalKey<NavigatorState>();

  BuildContext get context =>
      router.routerDelegate.navigatorKey.currentContext!;

  GoRouterDelegate get routerDelegate => router.routerDelegate;

  GoRouteInformationParser get routeInformationParser =>
      router.routeInformationParser;

  static Page getPage({
    required Widget child,
    required GoRouterState state,
  }) =>
      MaterialPage(key: state.pageKey, child: child);
}
