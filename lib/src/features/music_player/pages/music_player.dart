import 'dart:io';

import 'package:audiotagger/audiotagger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';

import '../../../common/widgets/space.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({required this.songs, required this.songIndex, Key? key})
      : super(key: key);

  final List<SongInfo> songs;
  final int songIndex;

  @override
  MusicPlayerState createState() => MusicPlayerState();
}

class MusicPlayerState extends State<MusicPlayer> {
  late final AudioPlayer _audioPlayer;
  late final ConcatenatingAudioSource _playlist;
  final tagger = Audiotagger();

  @override
  void initState() {
    _audioPlayer = AudioPlayer();
    _playlist = ConcatenatingAudioSource(
      useLazyPreparation: false,
      children: widget.songs
          .map(
            (song) => AudioSource.file(
              song.filePath!,
              tag: song,
            ),
          )
          .toList(),
    );
    _audioPlayer
      ..setAudioSource(
        _playlist,
        initialIndex: widget.songIndex,
        initialPosition: Duration.zero,
      )
      ..play();

    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<String?> _getLyrics() async {
    final lyrics = await tagger.readTags(path: widget.songs[0].filePath!);
    return lyrics?.lyrics;
  }

  void _showModalBottomSheet(BuildContext context, String text) {
    showModalBottomSheet<Object>(
      context: context,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<String?>(
                future: _getLyrics(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          snapshot.data!,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<SequenceState?>(
              stream: _audioPlayer.sequenceStateStream,
              builder: (context, snapshot) {
                final state = snapshot.data;
                final song =
                    widget.songs[state?.currentIndex ?? widget.songIndex];
                return song.albumArtwork == null
                    ? const SizedBox.shrink()
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: GestureDetector(
                          onTap: () => _showModalBottomSheet(context, 'text'),
                          child: Image.file(
                            File(song.albumArtwork!),
                            width: MediaQuery.of(context).size.width * 0.9,
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
              },
            ),
            Space.sm(),
            StreamBuilder<SequenceState?>(
              stream: _audioPlayer.sequenceStateStream,
              builder: (context, snapshot) {
                final state = snapshot.data;
                final song =
                    widget.songs[state?.currentIndex ?? widget.songIndex];
                return Text(
                  song.title!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                );
              },
            ),
            Space.sm(),
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
                IconButton(
                  icon: const Icon(Icons.skip_previous_outlined),
                  onPressed: () {
                    if (_audioPlayer.position.inSeconds > 3) {
                      _audioPlayer.seek(Duration.zero);
                    } else {
                      _audioPlayer.seekToPrevious();
                    }
                  },
                ),
                StreamBuilder<PlayerState>(
                  stream: _audioPlayer.playerStateStream,
                  builder: (context, snapshot) {
                    final playing = snapshot.data?.playing ?? false;
                    final buffering = snapshot.data?.processingState ==
                        ProcessingState.buffering;
                    return buffering
                        ? const SizedBox(
                            width: 64,
                            height: 64,
                            child: CircularProgressIndicator(),
                          )
                        : IconButton(
                            icon: Icon(
                              playing ? Icons.pause : Icons.play_arrow,
                            ),
                            iconSize: 64,
                            onPressed: playing
                                ? _audioPlayer.pause
                                : _audioPlayer.play,
                          );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.skip_next_outlined),
                  onPressed: () => setState(_audioPlayer.seekToNext),
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
      );
}
