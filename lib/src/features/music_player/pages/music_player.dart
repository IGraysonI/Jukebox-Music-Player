import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({required this.songs, required this.songIndex, Key? key})
      : super(key: key);

  final List<SongInfo> songs;
  final int songIndex;

  @override
  MusicPlayerState createState() => MusicPlayerState();
}

class MusicPlayerState extends State<MusicPlayer> {
  double minValue = 0;
  double maxValue = 0;
  double currentValue = 0;
  String currentTime = '';
  String endTime = '';
  bool isPlaying = false;
  int currentIndex = 0;

  late List<SongInfo> _songs;
  late SongInfo playingSong;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final GlobalKey<MusicPlayerState> key = GlobalKey<MusicPlayerState>();

  @override
  void initState() {
    _songs = widget.songs;
    currentIndex = widget.songIndex;
    setSong(_songs[currentIndex]);
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> setSong(SongInfo song) async {
    playingSong = song;
    await _audioPlayer.setUrl(playingSong.uri!);

    currentValue = minValue;
    maxValue = _audioPlayer.duration!.inMilliseconds.toDouble();

    setState(() {
      currentTime = _getDuration(currentValue);
      endTime = _getDuration(maxValue);
    });

    isPlaying = false;
    changeStatus();

    _audioPlayer.positionStream.listen((Duration p) {
      currentValue = p.inMilliseconds.toDouble();
      setState(() {
        currentTime = _getDuration(currentValue);
      });
      if (currentValue >= maxValue) {
        changeTrack(true);
      }
    });
  }

  void changeStatus() {
    setState(() {
      isPlaying = !isPlaying;
    });
    if (isPlaying) {
      _audioPlayer.play();
    } else {
      _audioPlayer.pause();
    }
  }

  String _getDuration(double value) {
    final duration = Duration(milliseconds: value.round());
    return "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  void seekTo(double value) {
    setState(() {
      currentValue = value;
      _audioPlayer.seek(Duration(milliseconds: currentValue.round()));
      currentTime = _getDuration(currentValue);
    });
  }

  void changeTrack(bool isNext) {
    if (isNext) {
      if (currentIndex != _songs.length - 1) {
        setState(() {
          currentIndex++;
        });
      }
    } else {
      if (currentIndex != 0) {
        setState(() {
          currentIndex--;
        });
      }
    }
    setSong(_songs[currentIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(playingSong.title!),
      ),
      body: Column(
        children: [
          Image(
            image: FileImage(
              File(playingSong.albumArtwork!),
            ),
          ),
          const SizedBox(height: 10),
          Text(playingSong.title!),
          const SizedBox(height: 10),
          Slider(
            min: minValue,
            max: maxValue,
            value: currentValue,
            onChanged: seekTo,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(currentTime),
              Text(endTime),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  if (currentValue > 5500) {
                    seekTo(minValue);
                  } else {
                    changeTrack(false);
                  }
                },
                icon: const Icon(Icons.skip_previous),
              ),
              IconButton(
                onPressed: changeStatus,
                icon: isPlaying
                    ? const Icon(Icons.pause)
                    : const Icon(Icons.play_arrow),
              ),
              IconButton(
                onPressed: () {
                  changeTrack(true);
                },
                icon: const Icon(Icons.skip_next),
              ),
            ],
          )
        ],
      ),
    );
  }
}
