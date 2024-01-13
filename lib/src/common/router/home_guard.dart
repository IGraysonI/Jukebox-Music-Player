import 'dart:async';

import 'package:jukebox_music_player/src/common/router/routes.dart';
import 'package:jukebox_music_player/src/features/jukebox_music_player/data/tabs_cache_service.dart';
import 'package:jukebox_music_player/src/features/jukebox_music_player/enum/navigation_tabs_enum.dart';
import 'package:octopus/octopus.dart';

/// Do not allow any nested routes at `bottomNavigation` inderectly except of `*-tab`.
class HomeGuard extends OctopusGuard {
  HomeGuard({
    TabsCacheService? cache,
  }) : _cache = cache;

  final TabsCacheService? _cache;

  static final String _songsTab = '${NavigationTabsEnum.songs.name}-tab';
  static final String _albumsTab = '${NavigationTabsEnum.albums.name}-tab';
  static final String _artistsTab = '${NavigationTabsEnum.artists.name}-tab';

  @override
  FutureOr<OctopusState> call(
    List<OctopusHistoryEntry> history,
    OctopusState$Mutable state,
    Map<String, Object?> context,
  ) {
    final bottomNavigation = state.findByName(Routes.bottomNavigation.name);
    if (bottomNavigation == null) return state; // Do nothing if `bottomNavigation` not found.

    // Restore state from cache if exists.
    if (!bottomNavigation.hasChildren) {
      _cache?.restore(state);
    }

    // Remove all nested routes except of `*-tab`.
    bottomNavigation.removeWhere(
      (node) => node.name != _albumsTab && node.name != _artistsTab,
      recursive: false,
    );
    // Upsert songs tab node if not exists.
    final songs = bottomNavigation.putIfAbsent(_songsTab, () => OctopusNode.mutable(_songsTab));
    if (!songs.hasChildren) songs.add(OctopusNode.mutable(Routes.songs.name));
    // Upsert albums tab node if not exists.
    final albums = bottomNavigation.putIfAbsent(_albumsTab, () => OctopusNode.mutable(_albumsTab));
    if (!albums.hasChildren) albums.add(OctopusNode.mutable(Routes.albums.name));
    // Upsert artists tab node if not exists.
    final artists = bottomNavigation.putIfAbsent(_artistsTab, () => OctopusNode.mutable(_artistsTab));
    if (!artists.hasChildren) artists.add(OctopusNode.mutable(Routes.artists.name));

    // Update cache.
    _cache?.save(state);
    return state;
  }
}
