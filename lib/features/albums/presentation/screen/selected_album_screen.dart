import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:jukebox_music_player/features/albums/presentation/widget/selected_album.dart';

class SelectedAlbumScreen extends StatefulWidget {
  final AlbumInfo albumInfo;
  const SelectedAlbumScreen({Key? key, required this.albumInfo})
      : super(key: key);

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
    List<SongInfo> _songs = [];
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
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
