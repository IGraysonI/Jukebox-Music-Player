import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';

class MusicPlayer extends StatefulWidget {
  SongInfo song;
  Function changeTrack;
  final GlobalKey<MusicPlayerState> key;
  MusicPlayer({
    required this.key,
    required this.song,
    required this.changeTrack,
  }) : super(key: key);

  @override
  MusicPlayerState createState() => MusicPlayerState();
}

class MusicPlayerState extends State<MusicPlayer> {
  double minValue = 0.0;
  double maxValue = 0.0;
  double currentValue = 0.0;
  String currentTime = "";
  String endTime = "";
  bool isPlaying = false;

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    setSong(widget.song);
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void setSong(SongInfo song) async {
    widget.song = song;
    await _audioPlayer.setUrl(widget.song.uri!);

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
        widget.changeTrack(true);
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
    Duration duration = Duration(milliseconds: value.round());
    return "${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}";
  }

  void seekTo(double value) {
    setState(() {
      currentValue = value;
      _audioPlayer.seek(Duration(milliseconds: currentValue.round()));
      currentTime = _getDuration(currentValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    SongInfo song = widget.song;
    return Scaffold(
      appBar: AppBar(
        title: Text(song.title!),
      ),
      body: Column(
        children: [
          Image(
            image: FileImage(
              File(song.albumArtwork!),
            ),
          ),
          SizedBox(height: 10),
          Text(song.title!),
          SizedBox(height: 10),
          Slider(
            min: minValue,
            max: maxValue,
            value: currentValue,
            onChanged: (value) {
              seekTo(value);
            },
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(currentTime),
              Text(endTime),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    if (currentValue > 5500) {
                      seekTo(minValue);
                    } else {
                      widget.changeTrack(false);
                    }
                  },
                  icon: Icon(Icons.skip_previous)),
              IconButton(
                  onPressed: () {
                    changeStatus();
                  },
                  icon: isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow)),
              IconButton(
                  onPressed: () {
                    widget.changeTrack(true);
                  },
                  icon: Icon(Icons.skip_next)),
            ],
          )
        ],
      ),
    );
  }
}
