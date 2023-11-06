import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';

import '../../../common/utils/player_utils.dart';
import '../../../common/widgets/space.dart';
import '../../mini_player/controller/mini_player_controller.dart';
import '../../mini_player/widget/miniplayer.dart';
import '../scope/music_player_root_scope.dart';

// final ValueNotifier<double> playerExpandProgress = ValueNotifier(200);

class DetailedPlayer extends StatefulWidget {
  const DetailedPlayer({super.key});

  @override
  State<DetailedPlayer> createState() => _DetailedPlayerState();
}

class _DetailedPlayerState extends State<DetailedPlayer> {
  final MiniplayerController controller = MiniplayerController();

  @override
  Widget build(BuildContext context) => StreamBuilder<SequenceState?>(
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
                final player = MusicPlayerRootScope.stateOf(context)!.player;
                final songInfo = snapshot.data!.currentSource!.tag as SongInfo;

                final isMiniplayer =
                    percentage < PlayerUtils.miniplayerPercentageDeclaration;

                final width = MediaQuery.of(context).size.width;
                final maxImageSize = width * 0.7;

                final image = ClipRRect(
                  borderRadius: isMiniplayer
                      ? BorderRadius.circular(0)
                      : BorderRadius.circular(20),
                  child: songInfo.albumArtwork != null
                      ? Image.file(
                          File(songInfo.albumArtwork!),
                          fit: isMiniplayer ? BoxFit.cover : BoxFit.fill,
                        )
                      : Image.asset(
                          'assets/images/no_image.jpg',
                          fit: BoxFit.cover,
                        ),
                );

                final buttonPlay = StreamBuilder<PlayerState>(
                  stream: player.playerStateStream,
                  builder: (context, snapshot) {
                    final playing = snapshot.data?.playing ?? false;
                    final buffering = snapshot.data?.processingState ==
                        ProcessingState.buffering;
                    return buffering
                        ? const SizedBox(child: CircularProgressIndicator())
                        : IconButton(
                            icon: Icon(
                              playing ? Icons.pause : Icons.play_arrow,
                            ),
                            iconSize: isMiniplayer ? 32 : 48,
                            onPressed: playing ? player.pause : player.play,
                          );
                  },
                );

                final songProgress = StreamBuilder<Duration?>(
                  stream: player.durationStream,
                  builder: (context, snapshot) {
                    final duration = snapshot.data ?? Duration.zero;
                    return StreamBuilder<Duration?>(
                      stream: player.positionStream,
                      builder: (context, snapshot) {
                        var position = snapshot.data ?? Duration.zero;
                        if (position > duration) {
                          position = duration;
                        }

                        var progress = 0.0;

                        if (duration.inMilliseconds > 0 &&
                            duration.inMilliseconds.isFinite) {
                          progress =
                              position.inMilliseconds / duration.inMilliseconds;
                        }

                        if (!isMiniplayer) {
                          return Slider(
                            value: position.inMilliseconds.toDouble(),
                            onChanged: (value) => player.seek(
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

                final buttonSkipForward = IconButton(
                  icon: const Icon(Icons.skip_next_outlined),
                  onPressed: player.seekToNext,
                );
                final buttonSkipBackwards = IconButton(
                  icon: const Icon(Icons.skip_previous_outlined),
                  onPressed: () {
                    if (player.position.inSeconds > 3) {
                      player.seek(Duration.zero);
                    } else {
                      player.seekToPrevious();
                    }
                  },
                );

                /// Expanded player widgets
                /// ---------------------------------------------------------
                if (!isMiniplayer) {
                  var percentageExpandedPlayer =
                      PlayerUtils.percentageFromValueInRange(
                    min: playerMaxHeight *
                            PlayerUtils.miniplayerPercentageDeclaration +
                        PlayerUtils.playerMinHeight,
                    max: playerMaxHeight,
                    value: height,
                  );

                  if (percentageExpandedPlayer < 0) {
                    percentageExpandedPlayer = 0;
                  }

                  final paddingVertical =
                      PlayerUtils.valueFromPercentageInRange(
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

                  final songProgressDuration = StreamBuilder<Duration?>(
                    stream: player.positionStream,
                    builder: (context, snapshot) {
                      var position = snapshot.data ?? Duration.zero;
                      return StreamBuilder<Duration?>(
                        stream: player.durationStream,
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
                  );

                  final buttonLoopMode = StreamBuilder<LoopMode>(
                    stream: player.loopModeStream,
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
                        onPressed: () => player.setLoopMode(
                          loopMode == LoopMode.off
                              ? LoopMode.one
                              : loopMode == LoopMode.one
                                  ? LoopMode.all
                                  : LoopMode.off,
                        ),
                      );
                    },
                  );

                  final buttonShuffleMode = StreamBuilder<bool>(
                    stream: player.shuffleModeEnabledStream,
                    builder: (context, snapshot) {
                      final shuffleModeEnabled = snapshot.data ?? false;
                      return IconButton(
                        icon: Icon(
                          shuffleModeEnabled
                              ? Icons.shuffle_on_outlined
                              : Icons.shuffle_outlined,
                        ),
                        onPressed: () => player.setShuffleModeEnabled(
                          !shuffleModeEnabled,
                        ),
                      );
                    },
                  );

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
                          child: SizedBox(height: imageSize, child: image),
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
                                Flexible(child: songProgress),
                                Flexible(child: songProgressDuration),
                                Flexible(child: Space.sm()),
                                Flexible(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      buttonLoopMode,
                                      buttonSkipBackwards,
                                      buttonPlay,
                                      buttonSkipForward,
                                      buttonShuffleMode,
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

                /// Miniplayer
                /// ------------------------------------------------------------
                final percentageMiniplayer =
                    PlayerUtils.percentageFromValueInRange(
                  min: PlayerUtils.playerMinHeight,
                  max: playerMaxHeight *
                          PlayerUtils.miniplayerPercentageDeclaration +
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
                            constraints:
                                BoxConstraints(maxHeight: maxImageSize),
                            child: image,
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
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
                                  buttonSkipBackwards,
                                  buttonPlay,
                                  buttonSkipForward,
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
                        child: songProgress,
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      );
}
