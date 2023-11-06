import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../widget/selected_album.dart';

class SelectedAlbumPage extends StatefulWidget {
  const SelectedAlbumPage({required this.album, super.key});

  final AlbumInfo album;

  @override
  State<SelectedAlbumPage> createState() => _SelectedAlbumPageState();
}

class _SelectedAlbumPageState extends State<SelectedAlbumPage> {
  late final AlbumInfo _album;
  late final List<SongInfo> _songs;
  final FlutterAudioQuery _audioQuery = FlutterAudioQuery();
  late Future<void> _initializeAudioFiles;

  @override
  void initState() {
    _album = widget.album;
    _initializeAudioFiles = _getAlbumSongs(_album);
    super.initState();
  }

  Future<void> _getAlbumSongs(AlbumInfo album) async {
    var songs = <SongInfo>[];
    songs = await _audioQuery.getSongsFromAlbum(albumId: album.id);
    setState(() => _songs = songs);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: FutureBuilder(
          future: _initializeAudioFiles,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SelectedAlbum(album: _album, songs: _songs);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      );
}
