import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../widget/albums_list.dart';

class AlbumListScreen extends StatefulWidget {
  const AlbumListScreen({required this.albums, Key? key}) : super(key: key);

  final List<AlbumInfo> albums;

  @override
  State<AlbumListScreen> createState() => _AlbumListScreenState();
}

class _AlbumListScreenState extends State<AlbumListScreen> {
  @override
  Widget build(BuildContext context) {
    return AlbumList(albums: widget.albums);
  }
}
