import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';

import '../../../common/utils/player_utils.dart';
import '../../../common/widgets/space.dart';
import '../../mini_player/controller/mini_player_controller.dart';
import '../../mini_player/widget/miniplayer.dart';
import '../scope/music_player_root_scope.dart';

class DetailedPlayer extends StatefulWidget {
  const DetailedPlayer({super.key});

  @override
  State<DetailedPlayer> createState() => _DetailedPlayerState();
}

class _DetailedPlayerState extends State<DetailedPlayer> {
  final MiniplayerController controller = MiniplayerController();
  bool _isMiniPlayer = false;
  AudioPlayer? _player;

  Widget _image(String? imagePath) => ClipRRect(
        borderRadius: _isMiniPlayer
            ? BorderRadius.circular(0)
            : BorderRadius.circular(20),
        child: imagePath != null
            ? Image.file(
                File(imagePath),
                fit: _isMiniPlayer ? BoxFit.cover : BoxFit.fill,
              )
            : Image.asset(
                'assets/images/no_image.jpg',
                fit: BoxFit.cover,
              ),
      );

  Widget _playButton() => StreamBuilder<PlayerState>(
        stream: _player?.playerStateStream,
        builder: (context, snapshot) {
          final playing = snapshot.data?.playing ?? false;
          final buffering =
              snapshot.data?.processingState == ProcessingState.buffering;
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

              if (duration.inMilliseconds > 0 &&
                  duration.inMilliseconds.isFinite) {
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
              shuffleModeEnabled
                  ? Icons.shuffle_on_outlined
                  : Icons.shuffle_outlined,
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
    SongInfo songInfo,
    double height,
    double width,
    double playerMaxHeight,
    double maxImageSize,
  ) {
    var percentageExpandedPlayer = PlayerUtils.percentageFromValueInRange(
      min: playerMaxHeight * PlayerUtils.miniplayerPercentageDeclaration +
          PlayerUtils.playerMinHeight,
      max: playerMaxHeight,
      value: height,
    );

    if (percentageExpandedPlayer < 0) {
      percentageExpandedPlayer = 0;
    }

    final paddingVertical = PlayerUtils.valueFromPercentageInRange(
      min: 0,
      max: 10,
      percentage: percentageExpandedPlayer,
    );

    final heightWithoutPadding = height - paddingVertical * 2;
    final imageSize = heightWithoutPadding > maxImageSize
        ? maxImageSize
        : heightWithoutPadding;
    final paddingLeft = PlayerUtils.valueFromPercentageInRange(
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
              child: _image(songInfo.albumArtwork),
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
                      songInfo.title ?? 'Title not found',
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
    SongInfo songInfo,
    double height,
    double width,
    double playerMaxHeight,
    double maxImageSize,
  ) {
    final percentageMiniplayer = PlayerUtils.percentageFromValueInRange(
      min: PlayerUtils.playerMinHeight,
      max: playerMaxHeight * PlayerUtils.miniplayerPercentageDeclaration +
          PlayerUtils.playerMinHeight,
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
                child: _image(songInfo.albumArtwork),
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
                          songInfo.title ?? 'Title not found',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          songInfo.artist ?? 'Artist not found',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .color!
                                        .withOpacity(0.55),
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

  @override
  Widget build(BuildContext context) => SafeArea(
        child: StreamBuilder<SequenceState?>(
          stream:
              MusicPlayerRootScope.stateOf(context)!.player.sequenceStateStream,
          builder: (context, snapshot) {
            final playerMaxHeight = MediaQuery.of(context).size.height;
            if (snapshot.hasData) {
              return Miniplayer(
                valueNotifier: playerExpandProgress,
                minHeight: PlayerUtils.playerMinHeight,
                maxHeight: playerMaxHeight,
                controller: controller,
                elevation: 4,
                onDismissed: null,
                curve: Curves.easeOut,
                builder: (height, percentage) {
                  _player = MusicPlayerRootScope.stateOf(context)!.player;
                  _isMiniPlayer =
                      percentage < PlayerUtils.miniplayerPercentageDeclaration;

                  final songInfo =
                      snapshot.data!.currentSource!.tag as SongInfo;
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