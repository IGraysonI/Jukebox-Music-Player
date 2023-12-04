import 'package:flutter_audio_query/flutter_audio_query.dart';

abstract interface class IAudioQueryRepository {
  /// Get all songs on device
  Future<List<SongInfo>> getSongs();

  /// Get all albums on device
  Future<List<AlbumInfo>> getAlbums();

  /// Get all artists on device
  Future<List<ArtistInfo>> getArtists();
}

class AudioQueryRepositoryImpl implements IAudioQueryRepository {
  AudioQueryRepositoryImpl();

  final FlutterAudioQuery audioQuery = FlutterAudioQuery();

  @override
  Future<List<SongInfo>> getSongs() async => audioQuery.getSongs();

  @override
  Future<List<AlbumInfo>> getAlbums() async => audioQuery.getAlbums();

  @override
  Future<List<ArtistInfo>> getArtists() async => audioQuery.getArtists();
}
