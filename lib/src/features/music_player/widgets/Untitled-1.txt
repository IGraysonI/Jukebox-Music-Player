import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';

import '../scope/music_player_root_scope.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  Widget build(BuildContext context) => Container(
        color: Theme.of(context).colorScheme.primary,
        height: MediaQuery.of(context).size.height * 0.1,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: StreamBuilder<SequenceState?>(
          stream:
              MusicPlayerRootScope.stateOf(context)!.player.sequenceStateStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final player = MusicPlayerRootScope.stateOf(context)!.player;
              final songInfo = snapshot.data!.currentSource!.tag as SongInfo;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                      ),
                      child: songInfo.albumArtwork != null
                          ? Image.file(
                              File(songInfo.albumArtwork!),
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/no_image.jpg',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          songInfo.title!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          songInfo.artist!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.skip_previous_outlined),
                          onPressed: () {
                            if (player.position.inSeconds > 3) {
                              player.seek(Duration.zero);
                            } else {
                              player.seekToPrevious();
                            }
                          },
                        ),
                        StreamBuilder<PlayerState>(
                          stream: MusicPlayerRootScope.stateOf(context)!
                              .player
                              .playerStateStream,
                          builder: (context, snapshot) {
                            final playing = snapshot.data?.playing ?? false;
                            final buffering = snapshot.data?.processingState ==
                                ProcessingState.buffering;
                            return buffering
                                ? const SizedBox(
                                    child: CircularProgressIndicator(),
                                  )
                                : IconButton(
                                    icon: Icon(
                                      playing ? Icons.pause : Icons.play_arrow,
                                    ),
                                    iconSize: 32,
                                    onPressed:
                                        playing ? player.pause : player.play,
                                  );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.skip_next_outlined),
                          onPressed: player.seekToNext,
                        ),
                      ],
                    ),
                  ),
                ],
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
        ),
      );
}
