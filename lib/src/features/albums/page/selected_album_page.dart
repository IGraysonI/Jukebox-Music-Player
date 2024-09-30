import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/features/albums/widget/selected_album.dart';
import 'package:jukevault/jukevault.dart';

class SelectedAlbumPage extends StatefulWidget {
  const SelectedAlbumPage({required this.album, super.key});

  final AlbumModel album;

  static String page() => 'SelectedAlbumPage';

  @override
  State<SelectedAlbumPage> createState() => _SelectedAlbumPageState();
}

class _SelectedAlbumPageState extends State<SelectedAlbumPage> {
  late final AlbumModel _album;
  late final List<AudioModel> _songs;
  late final Jukevault _jukevault;
  late Future<void> _initializeAudioFiles;

  @override
  void initState() {
    super.initState();
    _jukevault = Jukevault();
    _album = widget.album;
    _initializeAudioFiles = _getAlbumSongs(_album);
  }

  // TODO: Change logic, so the songs for selected album are fetched from the AudioQueryController
  Future<void> _getAlbumSongs(AlbumModel album) async {
    var songs = <AudioModel>[];
    // songs = await _audioQuery.getSongsFromAlbum(albumId: album.id);
    setState(() => _songs = songs);
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: _initializeAudioFiles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SelectedAlbum(album: _album, songs: _songs);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
}
