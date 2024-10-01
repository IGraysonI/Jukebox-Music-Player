import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/common/model/dependencies.dart';
import 'package:jukebox_music_player/src/features/audio_query/controller/audio_query_controller.dart';
import 'package:jukevault/jukevault.dart';

typedef SongID = String;
typedef AlbumID = String;
typedef ArtistID = String;

/// {@template audio_query_scope}
/// AudioQueryScope widget
/// {@endtemplate}
class AudioQueryScope extends StatefulWidget {
  /// {@macro audio_query_scope}
  const AudioQueryScope({
    required this.child,
    super.key,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// Refresh data.
  static void refresh(BuildContext context) => Dependencies.of(context).audioQueryController.fetch();

  /// Get list of [ArtistContent] on device.
  static List<ArtistContent> getArtists(
    BuildContext context, {
    bool listen = true,
  }) =>
      _InheritedArtists.getArtists(context, listen: listen);

  /// Get artist by [id] on device.
  static ArtistContent? getArtistById(
    BuildContext context,
    ArtistID id, {
    bool listen = true,
  }) =>
      _InheritedArtists.getArtistById(context, id, listen: listen);

  /// Get list of [AlbumContent] on device or by artist [id].
  static List<AlbumContent> getAlbums(
    BuildContext context, {
    bool listen = true,
  }) =>
      _InheritedAlbums.getAlbums(context, listen: listen);

  /// Get album by [AlbumID] on device.
  static AlbumContent? getAlbumById(
    BuildContext context,
    AlbumID id, {
    bool listen = true,
  }) =>
      _InheritedAlbums.getAlbumById(context, id, listen: listen);

  /// Get list of [AudioModel] on device or by album [id] or by artist [id].
  static List<AudioModel> getSongs(
    BuildContext context, {
    bool listen = true,
  }) =>
      _InheritedSongs.getSongs(context, listen: listen);

  /// Get song by [SongID] on device.
  static AudioModel? getSongById(
    BuildContext context,
    SongID id, {
    bool listen = true,
  }) =>
      _InheritedSongs.getSongById(context, id, listen: listen);

  @override
  State<AudioQueryScope> createState() => _AudioQueryScopeState();
}

/// State for widget [AudioQueryScope].
class _AudioQueryScopeState extends State<AudioQueryScope> {
  late final AudioQueryController _audioQueryController;
  List<ArtistModel> _artists = [];
  List<AlbumModel> _albums = [];
  List<AudioModel> _songs = [];
  Map<ArtistID, ArtistContent> _tableArtists = {};
  Map<AlbumID, AlbumContent> _tableAlbums = {};
  Map<SongID, AudioModel> _tableSongs = {};

  // #region lifecycle
  @override
  void initState() {
    super.initState();
    _audioQueryController = Dependencies.of(context).audioQueryController..fetch();
    _audioQueryController.addListener(_onStateChanged);
    _onStateChanged();
  }

  @override
  void dispose() {
    _audioQueryController
      ..removeListener(_onStateChanged)
      ..dispose();
    super.dispose();
  }
  // #endregion

  void _onStateChanged() {
    if (!mounted) return;
    if (identical(_artists, _audioQueryController.state.artists)) return;
    if (identical(_albums, _audioQueryController.state.albums)) return;
    if (identical(_songs, _audioQueryController.state.songs)) return;
    _artists = _audioQueryController.state.artists;
    _albums = _audioQueryController.state.albums;
    _songs = _audioQueryController.state.songs;
    _tableArtists = {};
    _tableAlbums = {};
    _tableSongs = {};
    for (final artist in _audioQueryController.state.artists) {
      _tableArtists[artist.id.toString()] = ArtistContent._(artist);
    }
    for (final album in _audioQueryController.state.albums) {
      _tableAlbums[album.id.toString()] = AlbumContent._(album);
    }
    for (final song in _audioQueryController.state.songs) {
      _tableSongs[song.id.toString()] = song;

      // Get the corresponding AlbumContent using the album ID
      final albumContent = _tableAlbums[song.albumId.toString()];

      // Check if albumContent is not null before updating
      if (albumContent != null) {
        albumContent._songs.add(_tableSongs[song.id.toString()]!);

        // Get the corresponding ArtistContent using the artist ID
        final artistContent = _tableArtists[song.artistId.toString()];

        // Check if artistContent is not null and the album is not already in the artist's albums list
        if (artistContent != null && !artistContent._albums.any((album) => album.album.id == song.albumId)) {
          artistContent._albums.add(albumContent);
        }
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) => _InheritedArtists(
        table: _tableArtists,
        child: _InheritedAlbums(
          table: _tableAlbums,
          child: _InheritedSongs(
            table: _tableSongs,
            child: widget.child,
          ),
        ),
      );
}

/// Album content.
@immutable
final class AlbumContent {
  AlbumContent._(this.album) : _songs = [];

  /// Current album.
  final AlbumModel album;

  /// List of songs in the album.
  final List<AudioModel> _songs;
  late final List<AudioModel> songs = UnmodifiableListView<AudioModel>(_songs);
}

/// Artist content.
@immutable
final class ArtistContent {
  ArtistContent._(this.artist) : _albums = [];

  /// Current artist.
  final ArtistModel artist;

  /// List of albums with songs by artist.
  final List<AlbumContent> _albums;
  late final List<AlbumContent> albums = UnmodifiableListView<AlbumContent>(_albums);
}

class _InheritedArtists extends InheritedModel<ArtistID> {
  const _InheritedArtists({
    required this.table,
    required super.child,
  });

  /// Table of artists.
  final Map<ArtistID, ArtistContent> table;

  static _InheritedArtists? maybeOf(
    BuildContext context, {
    bool listen = true,
  }) =>
      listen
          ? context.dependOnInheritedWidgetOfExactType<_InheritedArtists>()
          : context.getInheritedWidgetOfExactType<_InheritedArtists>();

  /// Get list of [ArtistContent] on device.
  static List<ArtistContent> getArtists(
    BuildContext context, {
    bool listen = true,
  }) =>
      (listen ? InheritedModel.inheritFrom<_InheritedArtists>(context, aspect: null) : maybeOf(context, listen: false))
          ?.table
          .values
          .toList() ??
      [];

  /// Get artist by [id] on device.
  static ArtistContent? getArtistById(
    BuildContext context,
    ArtistID id, {
    bool listen = true,
  }) =>
      (listen ? InheritedModel.inheritFrom<_InheritedArtists>(context, aspect: id) : maybeOf(context, listen: false))
          ?.table[id];

  @override
  bool updateShouldNotify(covariant _InheritedArtists old) => !identical(table, old.table);

  @override
  bool updateShouldNotifyDependent(
    covariant _InheritedArtists old,
    Set<ArtistID> aspects,
  ) {
    for (final id in aspects) {
      if (table[id] != old.table[id]) return true;
    }
    return false;
  }
}

class _InheritedAlbums extends InheritedModel<AlbumID> {
  const _InheritedAlbums({
    required this.table,
    required super.child,
  });

  /// Table of albums.
  final Map<AlbumID, AlbumContent> table;

  static _InheritedAlbums? maybeOf(
    BuildContext context, {
    bool listen = true,
  }) =>
      listen
          ? context.dependOnInheritedWidgetOfExactType<_InheritedAlbums>()
          : context.getInheritedWidgetOfExactType<_InheritedAlbums>();

  /// Get list of [AlbumContent] on device or by artist [id].
  static List<AlbumContent> getAlbums(
    BuildContext context, {
    bool listen = true,
  }) =>
      (listen ? InheritedModel.inheritFrom<_InheritedAlbums>(context, aspect: null) : maybeOf(context, listen: false))
          ?.table
          .values
          .toList() ??
      [];

  /// Get album by [AlbumID] on device.
  static AlbumContent? getAlbumById(
    BuildContext context,
    AlbumID id, {
    bool listen = true,
  }) =>
      (listen ? InheritedModel.inheritFrom<_InheritedAlbums>(context, aspect: id) : maybeOf(context, listen: false))
          ?.table[id];

  @override
  bool updateShouldNotify(covariant _InheritedAlbums old) => !identical(table, old.table);

  @override
  bool updateShouldNotifyDependent(
    covariant _InheritedAlbums old,
    Set<AlbumID> aspects,
  ) {
    for (final id in aspects) {
      if (table[id] != old.table[id]) return true;
    }
    return false;
  }
}

class _InheritedSongs extends InheritedModel<SongID> {
  const _InheritedSongs({
    required this.table,
    required super.child,
  });

  /// Table of songs.
  final Map<SongID, AudioModel> table;

  static _InheritedSongs? maybeOf(
    BuildContext context, {
    bool listen = true,
  }) =>
      listen
          ? context.dependOnInheritedWidgetOfExactType<_InheritedSongs>()
          : context.getInheritedWidgetOfExactType<_InheritedSongs>();

  /// Get list of [SongInfo] on device or by album [id] or by artist [id].
  static List<AudioModel> getSongs(
    BuildContext context, {
    bool listen = true,
  }) =>
      (listen ? InheritedModel.inheritFrom<_InheritedSongs>(context, aspect: null) : maybeOf(context, listen: false))
          ?.table
          .values
          .toList() ??
      [];

  /// Get song by [SongID] on device.
  static AudioModel? getSongById(
    BuildContext context,
    SongID id, {
    bool listen = true,
  }) =>
      (listen ? InheritedModel.inheritFrom<_InheritedSongs>(context, aspect: id) : maybeOf(context, listen: false))
          ?.table[id];

  @override
  bool updateShouldNotify(covariant _InheritedSongs old) => !identical(table, old.table);

  @override
  bool updateShouldNotifyDependent(
    covariant _InheritedSongs old,
    Set<SongID> aspects,
  ) {
    for (final id in aspects) {
      if (table[id] != old.table[id]) return true;
    }
    return false;
  }
}
