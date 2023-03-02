import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/logger/l.dart';
import '../data/audio_query_repository.dart';

part 'audio_query_bloc.freezed.dart';

/// Блок для работы с аудио файлами на устройстве пользователя (получение
///  списка аудио файлов, альбомов, исполнителей)
class AudioQueryBloc extends Bloc<AudioQueryEvent, AudioQueryState> {
  AudioQueryBloc({required AudioQueryRepository audioQueryRepository})
      : _audioQueryRepository = audioQueryRepository,
        super(const AudioQueryInitial()) {
    on<GetAudioFiles>(_getAudioFiles);
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

      emit(AudioQueryData(songs: songs, albums: albums, artists: artists));
    } on Exception catch (e, st) {
      l.e('AudioQueryCubit exception with error: $e and stactTrace: $st');
    }
  }
}

@freezed
class AudioQueryState with _$AudioQueryState {
  const AudioQueryState._();

  const factory AudioQueryState.initial() = AudioQueryInitial;

  const factory AudioQueryState.data({
    required List<SongInfo> songs,
    required List<AlbumInfo> albums,
    required List<ArtistInfo> artists,
  }) = AudioQueryData;

  List<SongInfo> get songs => maybeMap(
        data: (data) => data.songs,
        orElse: () => [],
      );

  List<AlbumInfo> get albums => maybeMap(
        data: (data) => data.albums,
        orElse: () => [],
      );

  List<ArtistInfo> get artists => maybeMap(
        data: (data) => data.artists,
        orElse: () => [],
      );
}

@freezed
class AudioQueryEvent with _$AudioQueryEvent {
  const AudioQueryEvent._();

  /// Получение списка аудио файлов, альбомов, исполнителей на устройстве
  /// пользователя
  const factory AudioQueryEvent.getAudioFiles() = GetAudioFiles;
}
