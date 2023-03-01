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
              Text(widget.song.title ?? ''),
              Space.sm(),
              ElevatedButton(
                onPressed: _audioPlayer.play,
                child: const Text('Play'),
              )
            ],
          ),
        ),
      );
}
