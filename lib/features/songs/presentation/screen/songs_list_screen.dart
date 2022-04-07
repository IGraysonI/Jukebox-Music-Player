import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:jukebox_music_player/features/songs/presentation/widget/songs_list.dart';

class SongsListScreen extends StatefulWidget {
  final List<SongInfo> songs;

  const SongsListScreen({
    Key? key,
    required this.songs,
  }) : super(key: key);

  @override
  State<SongsListScreen> createState() => _SongsListScreenState();
}

class _SongsListScreenState extends State<SongsListScreen> {
  @override
  Widget build(BuildContext context) {
    return SongsList(
      songs: widget.songs,
      shrinkWrap: false,
      isScrollable: true,
    );
  }
}
