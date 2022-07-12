import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../widget/songs_list.dart';

class SongsListScreen extends StatefulWidget {
  const SongsListScreen({required this.songs, Key? key}) : super(key: key);

  final List<SongInfo> songs;

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
