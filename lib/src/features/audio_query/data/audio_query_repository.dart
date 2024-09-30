import 'package:jukevault/jukevault.dart';

abstract interface class IAudioQueryRepository {
  /// Get all songs on device
  Future<List<AudioModel>> getSongs();

  /// Get all albums on device
  Future<List<AlbumModel>> getAlbums();

  /// Get all artists on device
  Future<List<ArtistModel>> getArtists();
}

class AudioQueryRepositoryImpl implements IAudioQueryRepository {
  AudioQueryRepositoryImpl();

  final Jukevault jukevault = Jukevault();

  @override
  Future<List<AudioModel>> getSongs() async => jukevault.querySongs();

  @override
  Future<List<AlbumModel>> getAlbums() async => jukevault.queryAlbums();

  @override
  Future<List<ArtistModel>> getArtists() async => jukevault.queryArtists();
}
