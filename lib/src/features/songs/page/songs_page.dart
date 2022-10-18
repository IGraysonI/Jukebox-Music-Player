import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../widget/songs_list.dart';

class SongsPage extends StatefulWidget {
  const SongsPage({required this.songs, Key? key}) : super(key: key);

  final List<SongInfo> songs;

  @override
  State<SongsPage> createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {
  @override
  Widget build(BuildContext context) {
    return SongsList(
      songs: widget.songs,
      isScrollable: true,
    );
  }
}
