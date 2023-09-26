import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:just_audio/just_audio.dart';

part 'music_player_bloc.freezed.dart';

class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicPlayerState> {
  MusicPlayerBloc() : super(MusicPlayerState.initial());
}

@freezed
class MusicPlayerState with _$MusicPlayerState {
  const factory MusicPlayerState({
    required final ConcatenatingAudioSource playlist,
    required final int currentIndex,
    @Default(false) bool isProcessing,
    Object? error,
    StackTrace? stackTrace,
  }) = MusicPlayerPlaying;

  const MusicPlayerState._();

  factory MusicPlayerState.initial() => MusicPlayerState(
        playlist: ConcatenatingAudioSource(children: []),
        currentIndex: 0,
      );
}

@freezed
class MusicPlayerEvent with _$MusicPlayerEvent {
  const MusicPlayerEvent._();
}
