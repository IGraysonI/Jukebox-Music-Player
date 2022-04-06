import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:jukebox_music_player/features/songs/presentation/screen/songs_list_screen.dart';

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

  @override
  void initState() {
    albumInfo = widget.albumInfo;
    // getAlbumSongs(albumInfo);
    super.initState();
  }

  Future<void> getAlbumSongs(AlbumInfo albumInfo) async {
    List<SongInfo> _songs = [];
    _songs = await audioQuery.getSongsFromAlbum(albumId: albumInfo.id);
    print(_songs);
    setState(() {
      songs = _songs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(albumInfo.title!),
      ),
      body: FutureBuilder(
        future: getAlbumSongs(albumInfo),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SongsListScreen(
              songs: songs,
            );
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
