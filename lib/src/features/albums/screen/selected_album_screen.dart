import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../widget/selected_album.dart';

class SelectedAlbumScreen extends StatefulWidget {
  const SelectedAlbumScreen({required this.albumInfo, Key? key})
      : super(key: key);
  final AlbumInfo albumInfo;

  @override
  State<SelectedAlbumScreen> createState() => _SelectedAlbumScreenState();
}

class _SelectedAlbumScreenState extends State<SelectedAlbumScreen> {
  late final AlbumInfo albumInfo;
  late final List<SongInfo> songs;
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  late Future<void> _initializeAudioFiles;

  @override
  void initState() {
    albumInfo = widget.albumInfo;
    _initializeAudioFiles = getAlbumSongs(albumInfo);
    super.initState();
  }

  Future<void> getAlbumSongs(AlbumInfo albumInfo) async {
    var _songs = <SongInfo>[];
    _songs = await audioQuery.getSongsFromAlbum(albumId: albumInfo.id);
    setState(() {
      songs = _songs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeAudioFiles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SelectedAlbum(albumInfo: albumInfo, songs: songs);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
