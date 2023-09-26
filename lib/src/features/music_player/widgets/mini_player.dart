import 'package:flutter/material.dart';

import '../scope/music_player_root_scope.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(
            MusicPlayerRootScope.stateOf(context)!
                .player
                .audioSource!
                .sequence
                .first
                .tag
                .toString(),
          ),
          ElevatedButton(
            onPressed: () => setState(() {}),
            child: const Text('Play'),
          ),
        ],
      );
}
