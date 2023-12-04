import '../../../common/controller/droppable_controller_concurrency.dart';
import '../../../common/controller/state_controller.dart';
import '../../../common/utils/error_util.dart';
import '../data/audio_query_repository.dart';
import 'audio_query_state.dart';

final class AudioQueryController extends StateController<AudioQueryState>
    with DroppableControllerConcurency {
  AudioQueryController({
    required IAudioQueryRepository audioQueryRepository,
    super.initialState =
        const AudioQueryState.idle(songs: [], albums: [], artists: []),
  }) : _audioQueryRepository = audioQueryRepository {
    getAudioFiles();
  }

  final IAudioQueryRepository _audioQueryRepository;

  /// Get all audio files [SongInfo], [AlbumInfo], [ArtistInfo] on device
  void getAudioFiles() => handle(
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
            AudioQueryState.idle(
              songs: songs,
              albums: albums,
              artists: artists,
              message: 'Audio files received',
            ),
          );
        },
        (error, _) => setState(
          AudioQueryState.idle(
            songs: state.songs,
            albums: state.albums,
            artists: state.artists,
            message: 'Error getting audio files',
            error: ErrorUtil.formatMessage(error),
          ),
        ),
        () => setState(
          AudioQueryState.idle(
            songs: state.songs,
            albums: state.albums,
            artists: state.artists,
            message: 'Getting audio files done',
          ),
        ),
      );
}
