import 'package:equatable/equatable.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logger/l.dart';
import '../data/audio_query_repository.dart';

part 'audio_query_state.dart';

/// Кубит для аудио файлов
class AudioQueryCubit extends Cubit<AudioQueryState> {
  AudioQueryCubit({required AudioQueryRepository audioQueryRepository})
      : _audioQueryRepository = audioQueryRepository,
        super(AudioQueryInitial()) {
    _getAudioFiles();
  }

  final AudioQueryRepository _audioQueryRepository;

  Future<void> _getAudioFiles() async {
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
