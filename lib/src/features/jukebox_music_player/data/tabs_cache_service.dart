import 'dart:convert';

import 'package:jukebox_music_player/src/common/router/routes.dart';
import 'package:octopus/octopus.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Restore cached nested navigation on tab switch
class TabsCacheService {
  TabsCacheService({
    required SharedPreferences sharedPreferences,
  }) : _prefs = sharedPreferences;

  static const String _key = 'bottomNavigation.tabs';

  final SharedPreferences _prefs;

  /// Save nested navigation to cache
  Future<void> save(OctopusState state) async {
    try {
      final argument = state.arguments['bottomNavigation'];
      final bottomNavigation = state.findByName(Routes.bottomNavigation.name);
      if (bottomNavigation == null) return;
      final songs = bottomNavigation.findByName('songs-tab');
      final albums = bottomNavigation.findByName('albums-tab');
      final artists = bottomNavigation.findByName('artists-tab');
      final json = <String, Object?>{
        if (argument != null) 'tab': argument,
        if (songs != null) 'songs': songs.toJson(),
        if (albums != null) 'albums': albums.toJson(),
        if (artists != null) 'artists': artists.toJson(),
      };
      if (json.isEmpty) return;
      await _prefs.setString(_key, jsonEncode(json));
    } on Object {/* ignore */}
  }

  /// Restore nested navigation from cache
  Future<OctopusState$Mutable?> restore(OctopusState$Mutable state) async {
    final bottomNavigation = state.findByName(Routes.bottomNavigation.name);
    if (bottomNavigation == null) return null; // Do nothing if `bottomNavigation` not found.
    try {
      final jsonRaw = _prefs.getString(_key);
      if (jsonRaw == null) return null;
      final json = jsonDecode(jsonRaw);
      if (json case Map<String, Object?> data) {
        if (data['tab'] case String tab) state.arguments['bottomNavigation'] = tab;
        if (data['songs'] case Map<String, Object?> songs)
          bottomNavigation.putIfAbsent('songs-tab', () => OctopusNode.fromJson(songs));
        if (data['albums'] case Map<String, Object?> albums)
          bottomNavigation.putIfAbsent('albums-tab', () => OctopusNode.fromJson(albums));
        if (data['artists'] case Map<String, Object?> artists)
          bottomNavigation.putIfAbsent('artists-tab', () => OctopusNode.fromJson(artists));
        return state;
      }
    } on Object {/* ignore */}
    return null;
  }

  Future<void> clear() => _prefs.remove(_key);
}
