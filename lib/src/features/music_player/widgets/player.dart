import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';

import '../../../common/utils/player_utils.dart';
import '../../mini_player/controller/mini_player_controller.dart';
import '../../mini_player/widget/miniplayer.dart';
import '../scope/music_player_root_scope.dart';

final ValueNotifier<double> playerExpandProgress =
    ValueNotifier(playerMinHeight);

final MiniplayerController controller = MiniplayerController();

void onTap() {}

class DetailedPlayer extends StatelessWidget {
  const DetailedPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<SequenceState?>(
        stream:
            MusicPlayerRootScope.stateOf(context)!.player.sequenceStateStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Miniplayer(
              valueNotifier: playerExpandProgress,
              minHeight: playerMinHeight,
              maxHeight: playerMaxHeight,
              controller: controller,
              elevation: 4,
              onDismissed: () {},
              curve: Curves.easeOut,
              builder: (height, percentage) {
                final player = MusicPlayerRootScope.stateOf(context)!.player;
                final songInfo = snapshot.data!.currentSource!.tag as SongInfo;
                final miniplayer = percentage < miniplayerPercentageDeclaration;
                final width = MediaQuery.of(context).size.width;
                final maxImgSize = width * 0.4;
                final img = songInfo.albumArtwork != null
                    ? Image.file(
                        File(songInfo.albumArtwork!),
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/no_image.jpg',
                        fit: BoxFit.cover,
                      );
                final text = Text(songInfo.title!);
                const buttonPlay = IconButton(
                  icon: Icon(Icons.pause),
                  onPressed: onTap,
                );
                const progressIndicator = LinearProgressIndicator(value: 0.3);

                // Declare additional widgets (eg. SkipButton) and variables
                if (!miniplayer) {
                  var percentageExpandedPlayer = percentageFromValueInRange(
                    min: playerMaxHeight * miniplayerPercentageDeclaration +
                        playerMinHeight,
                    max: playerMaxHeight,
                    value: height,
                  );
                  if (percentageExpandedPlayer < 0) {
                    percentageExpandedPlayer = 0;
                  }
                  final paddingVertical = valueFromPercentageInRange(
                    min: 0,
                    max: 10,
                    percentage: percentageExpandedPlayer,
                  );
                  final heightWithoutPadding = height - paddingVertical * 2;
                  final imageSize = heightWithoutPadding > maxImgSize
                      ? maxImgSize
                      : heightWithoutPadding;
                  final paddingLeft = valueFromPercentageInRange(
                        min: 0,
                        max: width - imageSize,
                        percentage: percentageExpandedPlayer,
                      ) /
                      2;

                  const buttonSkipForward = IconButton(
                    icon: Icon(Icons.forward_30),
                    iconSize: 33,
                    onPressed: onTap,
                  );
                  const buttonSkipBackwards = IconButton(
                    icon: Icon(Icons.replay_10),
                    iconSize: 33,
                    onPressed: onTap,
                  );
                  const buttonPlayExpanded = IconButton(
                    icon: Icon(Icons.pause_circle_filled),
                    iconSize: 50,
                    onPressed: onTap,
                  );

                  return Column(
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
                            child: img,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 33),
                          child: Opacity(
                            opacity: percentageExpandedPlayer,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(child: text),
                                const Flexible(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      buttonSkipBackwards,
                                      buttonPlayExpanded,
                                      buttonSkipForward,
                                    ],
                                  ),
                                ),
                                const Flexible(child: progressIndicator),
                                Container(),
                                Container(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }

                //Miniplayer
                final percentageMiniplayer = percentageFromValueInRange(
                  min: playerMinHeight,
                  max: playerMaxHeight * miniplayerPercentageDeclaration +
                      playerMinHeight,
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
                            constraints: BoxConstraints(maxHeight: maxImgSize),
                            child: img,
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
                                      songInfo.title!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(fontSize: 16),
                                    ),
                                    Text(
                                      songInfo.artist!,
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
                          IconButton(
                            icon: const Icon(Icons.fullscreen),
                            onPressed: () {
                              controller.animateToHeight(state: PanelState.max);
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 3),
                            child: Opacity(
                              opacity: elementOpacity,
                              child: buttonPlay,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: progressIndicatorHeight,
                      child: Opacity(
                        opacity: elementOpacity,
                        child: progressIndicator,
                      ),
                    ),
                  ],
                );
              },
            );
          } else {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  'Нет воспроизводимых треков',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            );
          }
        },
      );
}
