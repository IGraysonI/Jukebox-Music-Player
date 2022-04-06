import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:jukebox_music_player/features/albums/presentation/widget/albums_list.dart';
import 'package:jukebox_music_player/screens/music_player.dart';

class AlbumListScreen extends StatefulWidget {
  final List<AlbumInfo> albums;

  const AlbumListScreen({
    Key? key,
    required this.albums,
  }) : super(key: key);

  @override
  State<AlbumListScreen> createState() => _AlbumListScreenState();
}

class _AlbumListScreenState extends State<AlbumListScreen> {
  @override
  Widget build(BuildContext context) {
    return AlbumList(
      albums: widget.albums,
    );
  }
}
