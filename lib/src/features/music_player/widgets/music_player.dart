import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/common/util/player_util.dart';
import 'package:jukebox_music_player/src/common/widgets/basic/space.dart';
import 'package:jukebox_music_player/src/features/music_player/scope/music_player_scope.dart';
import 'package:jukebox_music_player/src/features/music_player/widgets/miniplayer.dart';
import 'package:jukevault/jukevault.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({super.key});

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  //TODO: Refactor core package
  // late Audiotagger _audioTagger;
  bool _isMiniPlayer = false;
  AudioPlayer? _player;
  String? _songLyrics;

  @override
  void initState() {
    super.initState();
    // _audioTagger = Audiotagger();
  }

  // Future<void> _getSongLyrics(AudioModel songInfo) async {
  //   Tag? songTags;
  //   if (songInfo.filePath != null) songTags = await _audioTagger.readTags(path: songInfo.filePath!);
  //   if (songTags != null) _songLyrics = songTags.lyrics;
  //   setState(() {});
  // }

  Widget _image(String? imagePath) => GestureDetector(
        onTap: () => _showModalBottomSheet(context),
        child: ClipRRect(
          borderRadius: _isMiniPlayer ? BorderRadius.circular(0) : BorderRadius.circular(20),
          child: imagePath != null
              ? Image.file(
                  File(imagePath),
                  fit: _isMiniPlayer ? BoxFit.cover : BoxFit.fill,
                )
              : Image.asset(
                  'assets/images/no_image.jpg',
                  fit: BoxFit.cover,
                ),
        ),
      );

  Widget _playButton() => StreamBuilder<PlayerState>(
        stream: _player?.playerStateStream,
        builder: (context, snapshot) {
          final playing = snapshot.data?.playing ?? false;
          final buffering = snapshot.data?.processingState == ProcessingState.buffering;
          return buffering
              ? const SizedBox(child: CircularProgressIndicator())
              : IconButton(
                  icon: Icon(
                    playing ? Icons.pause : Icons.play_arrow,
                  ),
                  iconSize: _isMiniPlayer ? 32 : 48,
                  onPressed: playing ? _player?.pause : _player?.play,
                );
        },
      );

  Widget _skipForwardButtom() => IconButton(
        icon: const Icon(Icons.skip_next_outlined),
        onPressed: _player?.seekToNext,
      );

  Widget _songProgress() => StreamBuilder<Duration?>(
        stream: _player?.durationStream,
        builder: (context, snapshot) {
          final duration = snapshot.data ?? Duration.zero;
          return StreamBuilder<Duration?>(
            stream: _player?.positionStream,
            builder: (context, snapshot) {
              var position = snapshot.data ?? Duration.zero;
              if (position > duration) {
                position = duration;
              }

              var progress = 0.0;

              if (duration.inMilliseconds > 0 && duration.inMilliseconds.isFinite) {
                progress = position.inMilliseconds / duration.inMilliseconds;
              }

              if (!_isMiniPlayer) {
                return Slider(
                  value: position.inMilliseconds.toDouble(),
                  onChanged: (value) => _player?.seek(
                    Duration(milliseconds: value.toInt()),
                  ),
                  min: 0,
                  max: duration.inMilliseconds.toDouble(),
                );
              } else {
                return LinearProgressIndicator(
                  value: progress.isFinite ? progress : 0.0,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                  backgroundColor: Theme.of(context).dividerColor,
                );
              }
            },
          );
        },
      );

  Widget _skipBackwardButton() => IconButton(
        icon: const Icon(Icons.skip_previous_outlined),
        onPressed: () {
          if (_player!.position.inSeconds > 3) {
            _player?.seek(Duration.zero);
          } else {
            _player?.seekToPrevious();
          }
        },
      );

  Widget _expandedSongProgressDuration() => StreamBuilder<Duration?>(
        stream: _player?.positionStream,
        builder: (context, snapshot) {
          var position = snapshot.data ?? Duration.zero;
          return StreamBuilder<Duration?>(
            stream: _player?.durationStream,
            builder: (context, snapshot) {
              final duration = snapshot.data ?? Duration.zero;
              if (position > duration) {
                position = duration;
              }
              return Text(
                '''${position.inMinutes}:${position.inSeconds.remainder(60).toString().padLeft(2, '0')} '''
                '''/ ${duration.inMinutes}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}''',
                style: Theme.of(context).textTheme.bodySmall,
              );
            },
          );
        },
      );

  Widget _shuffleModeButton() => StreamBuilder<bool>(
        stream: _player?.shuffleModeEnabledStream,
        builder: (context, snapshot) {
          final shuffleModeEnabled = snapshot.data ?? false;
          return IconButton(
            icon: Icon(
              shuffleModeEnabled ? Icons.shuffle_on_outlined : Icons.shuffle_outlined,
            ),
            onPressed: () => _player?.setShuffleModeEnabled(
              !shuffleModeEnabled,
            ),
          );
        },
      );

  Widget _loopModeButton() => StreamBuilder<LoopMode>(
        stream: _player?.loopModeStream,
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
            onPressed: () => _player?.setLoopMode(
              loopMode == LoopMode.off
                  ? LoopMode.one
                  : loopMode == LoopMode.one
                      ? LoopMode.all
                      : LoopMode.off,
            ),
          );
        },
      );

  Widget _expandedPlayer(
    AudioModel songInfo,
    double height,
    double width,
    double playerMaxHeight,
    double maxImageSize,
  ) {
    var percentageExpandedPlayer = PlayerUtil.percentageFromValueInRange(
      min: playerMaxHeight * PlayerUtil.miniplayerPercentageDeclaration + PlayerUtil.playerMinHeight,
      max: playerMaxHeight,
      value: height,
    );

    if (percentageExpandedPlayer < 0) {
      percentageExpandedPlayer = 0;
    }

    final paddingVertical = PlayerUtil.valueFromPercentageInRange(
      min: 0,
      max: 10,
      percentage: percentageExpandedPlayer,
    );

    final heightWithoutPadding = height - paddingVertical * 2;
    final imageSize = heightWithoutPadding > maxImageSize ? maxImageSize : heightWithoutPadding;
    final paddingLeft = PlayerUtil.valueFromPercentageInRange(
          min: 0,
          max: width - imageSize,
          percentage: percentageExpandedPlayer,
        ) /
        2;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(
              left: paddingLeft,
              top: paddingVertical,
              bottom: paddingVertical,
            ),
            child: SizedBox(
              height: imageSize,
              child: _image(songInfo.uri),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 33),
            child: Opacity(
              opacity: percentageExpandedPlayer,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      songInfo.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Flexible(child: _songProgress()),
                  Flexible(
                    child: _expandedSongProgressDuration(),
                  ),
                  Flexible(child: Space.sm()),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _loopModeButton(),
                        _skipBackwardButton(),
                        _playButton(),
                        _skipForwardButtom(),
                        _shuffleModeButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _miniPlayer(
    AudioModel songInfo,
    double height,
    double width,
    double playerMaxHeight,
    double maxImageSize,
  ) {
    final percentageMiniplayer = PlayerUtil.percentageFromValueInRange(
      min: PlayerUtil.playerMinHeight,
      max: playerMaxHeight * PlayerUtil.miniplayerPercentageDeclaration + PlayerUtil.playerMinHeight,
      value: height,
    );

    final elementOpacity = 1 - 1 * percentageMiniplayer;
    final progressIndicatorHeight = 4 - 4 * percentageMiniplayer;

    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: maxImageSize),
                child: _image(songInfo.uri),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Opacity(
                    opacity: elementOpacity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          songInfo.title,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          songInfo.artist ?? 'Artist not found',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.55),
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 3),
                child: Opacity(
                  opacity: elementOpacity,
                  child: Row(
                    children: [
                      _skipBackwardButton(),
                      _playButton(),
                      _skipForwardButtom(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: progressIndicatorHeight,
          child: Opacity(
            opacity: elementOpacity,
            child: _songProgress(),
          ),
        ),
      ],
    );
  }

  //TODO: ? Add cover change to lyrics box with scroll
  void _showModalBottomSheet(BuildContext context) => showModalBottomSheet<Widget>(
        showDragHandle: true,
        context: context,
        builder: (context) => SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              _songLyrics ?? 'Lyrics not found',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          )),
        ),
      );

  @override
  Widget build(BuildContext context) => SafeArea(
        child: StreamBuilder<SequenceState?>(
          stream: MusicPlayerScope.audioPlayerOf(context).sequenceStateStream,
          builder: (context, snapshot) {
            final playerMaxHeight = MediaQuery.of(context).size.height;
            if (snapshot.hasData) {
              // _getSongLyrics(snapshot.data!.currentSource!.tag as SongInfo);
              return Miniplayer(
                minHeight: PlayerUtil.playerMinHeight,
                maxHeight: playerMaxHeight,
                elevation: 4,
                curve: Curves.easeOut,
                builder: (height, percentage) {
                  _player = MusicPlayerScope.audioPlayerOf(context);
                  _isMiniPlayer = percentage < PlayerUtil.miniplayerPercentageDeclaration;

                  final songInfo = snapshot.data!.currentSource!.tag as AudioModel;
                  final width = MediaQuery.of(context).size.width;
                  final maxImageSize = width * 0.7;

                  if (!_isMiniPlayer) {
                    return _expandedPlayer(
                      songInfo,
                      height,
                      width,
                      playerMaxHeight,
                      maxImageSize,
                    );
                  }

                  return _miniPlayer(
                    songInfo,
                    height,
                    width,
                    playerMaxHeight,
                    maxImageSize,
                  );
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      );
}
