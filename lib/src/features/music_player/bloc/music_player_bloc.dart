import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:just_audio/just_audio.dart';

part 'music_player_bloc.freezed.dart';

class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicPlayerState> {
  MusicPlayerBloc() : super(const MusicPlayerInitial()) {
    on<MusicPlayerPlayPlaylist>(_playPlaylist);
  }

  final player = AudioPlayer();

  Future<void> _playPlaylist(
    MusicPlayerPlayPlaylist event,
    Emitter<MusicPlayerState> emit,
  ) async {
    await player.setAudioSource(
      event.playlist,
      initialIndex: event.selectedSongIndex,
    );
    await player.play();
    emit(
      MusicPlayerPlaying(
        playlist: event.playlist,
        currentIndex: event.selectedSongIndex,
      ),
    );
  }
}

@freezed
class MusicPlayerState with _$MusicPlayerState {
  const MusicPlayerState._();

  const factory MusicPlayerState.initial() = MusicPlayerInitial;

  const factory MusicPlayerState.playing({
    required ConcatenatingAudioSource playlist,
    required int currentIndex,
  }) = MusicPlayerPlaying;
}

@freezed
class MusicPlayerEvent with _$MusicPlayerEvent {
  const MusicPlayerEvent._();

  const factory MusicPlayerEvent.playPlaylist({
    required ConcatenatingAudioSource playlist,
    required int selectedSongIndex,
  }) = MusicPlayerPlayPlaylist;
}
