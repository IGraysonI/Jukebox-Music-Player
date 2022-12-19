part of 'audio_query_cubit.dart';

abstract class AudioQueryState extends Equatable {
  const AudioQueryState();
}

class AudioQueryInitial extends AudioQueryState {
  @override
  List<Object> get props => [];
}

class AudioQueryData extends AudioQueryState {
  const AudioQueryData({
    required this.songs,
    required this.albums,
    required this.artists,
  });

  final List<SongInfo> songs;
  final List<AlbumInfo> albums;
  final List<ArtistInfo> artists;

  @override
  List<Object> get props => [songs, albums, artists];
}
