import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/logger/l.dart';
import '../data/audio_query_repository.dart';

part 'audio_query_bloc.freezed.dart';

/// Блок для работы с аудио файлами на устройстве пользователя (получение
/// списка аудио файлов, альбомов, исполнителей)
class AudioQueryBloc extends Bloc<AudioQueryEvent, AudioQueryState> {
  AudioQueryBloc({required AudioQueryRepository audioQueryRepository})
      : _audioQueryRepository = audioQueryRepository,
        super(AudioQueryState.initial()) {
    on<GetAudioFiles>(_getAudioFiles);
    add(const AudioQueryEvent.getAudioFiles());
  }

  final AudioQueryRepository _audioQueryRepository;

  /// Получение списка аудио файлов, альбомов, исполнителей
  Future<void> _getAudioFiles(
    GetAudioFiles event,
    Emitter<AudioQueryState> emit,
  ) async {
    try {
      final songs = await _audioQueryRepository.getSongs();
      final albums = await _audioQueryRepository.getAlbums();
      final artists = await _audioQueryRepository.getArtists();

      emit(
        state.copyWith(
          songs: songs,
          albums: albums,
          artists: artists,
          isProcessing: false,
        ),
      );
    } on Exception catch (e, st) {
      l.e('AudioQueryCubit exception with error: $e and stactTrace: $st');
    }
  }
}

@freezed
class AudioQueryState with _$AudioQueryState {
  const factory AudioQueryState({
    required final List<SongInfo> songs,
    required final List<AlbumInfo> albums,
    required final List<ArtistInfo> artists,
    @Default(false) bool isProcessing,
    Object? error,
    StackTrace? stackTrace,
  }) = _AudioQueryState;

  const AudioQueryState._();

  factory AudioQueryState.initial() => const AudioQueryState(
        songs: [],
        albums: [],
        artists: [],
        isProcessing: true,
      );
}

@freezed
class AudioQueryEvent with _$AudioQueryEvent {
  const AudioQueryEvent._();

  /// Получение списка аудио файлов, альбомов, исполнителей на устройстве
  /// пользователя
  const factory AudioQueryEvent.getAudioFiles() = GetAudioFiles;
}
