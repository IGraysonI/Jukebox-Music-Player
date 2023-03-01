import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';

import '../../../common/widgets/space.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({required this.song, Key? key}) : super(key: key);

  final SongInfo song;

  @override
  MusicPlayerState createState() => MusicPlayerState();
}

class MusicPlayerState extends State<MusicPlayer> {
  late final AudioPlayer _audioPlayer;

  @override
  void initState() {
    _audioPlayer = AudioPlayer();
    _audioPlayer.setUrl(widget.song.filePath!);
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(widget.song.title ?? '')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder<Duration?>(
                stream: _audioPlayer.durationStream,
                builder: (context, snapshot) {
                  final duration = snapshot.data ?? Duration.zero;
                  return StreamBuilder<Duration?>(
                    stream: _audioPlayer.positionStream,
                    builder: (context, snapshot) {
                      var position = snapshot.data ?? Duration.zero;
                      if (position > duration) {
                        position = duration;
                      }
                      return Slider(
                        value: position.inMilliseconds.toDouble(),
                        onChanged: (value) => _audioPlayer
                            .seek(Duration(milliseconds: value.round())),
                        min: 0,
                        max: duration.inMilliseconds.toDouble(),
                      );
                    },
                  );
                },
              ),
              Space.sm(),
              StreamBuilder<Duration?>(
                stream: _audioPlayer.positionStream,
                builder: (context, snapshot) {
                  var position = snapshot.data ?? Duration.zero;
                  return StreamBuilder<Duration?>(
                    stream: _audioPlayer.durationStream,
                    builder: (context, snapshot) {
                      final duration = snapshot.data ?? Duration.zero;
                      if (position > duration) {
                        position = duration;
                      }
                      return Text(
                        '${position.inMinutes}:${position.inSeconds.remainder(60).toString().padLeft(2, '0')} / ${duration.inMinutes}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                        style: Theme.of(context).textTheme.bodySmall,
                      );
                    },
                  );
                },
              ),
              Space.sm(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StreamBuilder<LoopMode>(
                    stream: _audioPlayer.loopModeStream,
                    builder: (context, snapshot) {
                      final loopMode = snapshot.data ?? LoopMode.off;
                      return IconButton(
                        icon: Icon(
                          loopMode == LoopMode.off
                              ? Icons.repeat_outlined
                              : loopMode == LoopMode.one
                                  ? Icons.repeat_one_outlined
                                  : Icons.repeat_on_outlined,
                        ),
                        onPressed: () => _audioPlayer.setLoopMode(
                          loopMode == LoopMode.off
                              ? LoopMode.one
                              : loopMode == LoopMode.one
                                  ? LoopMode.all
                                  : LoopMode.off,
                        ),
                      );
                    },
                  ),
                  StreamBuilder<PlayerState>(
                    stream: _audioPlayer.playerStateStream,
                    builder: (context, snapshot) {
                      final playing = snapshot.data?.playing ?? false;
                      return IconButton(
                        icon: Icon(playing ? Icons.pause : Icons.play_arrow),
                        iconSize: 64,
                        onPressed:
                            playing ? _audioPlayer.pause : _audioPlayer.play,
                      );
                    },
                  ),
                  StreamBuilder<bool>(
                    stream: _audioPlayer.shuffleModeEnabledStream,
                    builder: (context, snapshot) {
                      final shuffleModeEnabled = snapshot.data ?? false;
                      return IconButton(
                        icon: Icon(
                          shuffleModeEnabled
                              ? Icons.shuffle_on_outlined
                              : Icons.shuffle_outlined,
                        ),
                        onPressed: () => _audioPlayer.setShuffleModeEnabled(
                          !shuffleModeEnabled,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
