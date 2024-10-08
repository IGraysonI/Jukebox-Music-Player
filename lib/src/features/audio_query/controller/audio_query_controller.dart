import 'package:control/control.dart';
import 'package:jukebox_music_player/src/features/audio_query/controller/audio_query_state.dart';
import 'package:jukebox_music_player/src/features/audio_query/data/audio_query_repository.dart';

final class AudioQueryController extends StateController<AudioQueryState> with DroppableControllerHandler {
  AudioQueryController({
    required IAudioQueryRepository audioQueryRepository,
    super.initialState = const AudioQueryState.idle(songs: [], albums: [], artists: []),
  }) : _audioQueryRepository = audioQueryRepository;

  final IAudioQueryRepository _audioQueryRepository;

  /// Get all audio files [SongInfo], [AlbumInfo], [ArtistInfo] on device
  void fetch() => handle(
        () async {
          setState(
            AudioQueryState.processing(
              songs: state.songs,
              albums: state.albums,
              artists: state.artists,
              message: 'Getting audio files',
            ),
          );
          final songs = await _audioQueryRepository.getSongs();
          final albums = await _audioQueryRepository.getAlbums();
          final artists = await _audioQueryRepository.getArtists();
          setState(
            AudioQueryState.successful(
              songs: songs,
              albums: albums,
              artists: artists,
              message: 'Audio files received',
            ),
          );
        },
        error: (error, s) async => setState(AudioQueryState.error(
          songs: state.songs,
          albums: state.albums,
          artists: state.artists,
          message: error.toString(),
        )),
        done: () async => setState(
          AudioQueryState.idle(
            songs: state.songs,
            albums: state.albums,
            artists: state.artists,
            message: 'Audio files received',
          ),
        ),
      );
}
