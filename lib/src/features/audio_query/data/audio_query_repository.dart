import 'package:flutter_audio_query/flutter_audio_query.dart';

/// Репозиторий для музыкалых файлов
class AudioQueryRepository {
  AudioQueryRepository();

  final FlutterAudioQuery audioQuery = FlutterAudioQuery();

  Future<List<SongInfo>> getSongs() async => audioQuery.getSongs();

  Future<List<AlbumInfo>> getAlbums() async => audioQuery.getAlbums();

  Future<List<ArtistInfo>> getArtists() async => audioQuery.getArtists();
}
