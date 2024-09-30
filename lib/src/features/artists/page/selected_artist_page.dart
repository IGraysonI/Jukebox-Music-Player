import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/features/artists/widget/selected_artist.dart';
import 'package:jukevault/jukevault.dart';

class SelectedArtistPage extends StatefulWidget {
  const SelectedArtistPage({required this.artist, super.key});

  final ArtistModel artist;

  static String page() => 'SelectedArtistPage';

  @override
  State<SelectedArtistPage> createState() => _SelectedArtistPageState();
}

class _SelectedArtistPageState extends State<SelectedArtistPage> {
  late final ArtistModel _artist;
  late final List<AlbumModel> _albums;
  late final Jukevault _jukevault;
  late Future<void> _initializeAudioFiles;

  @override
  void initState() {
    super.initState();
    _jukevault = Jukevault();
    _artist = widget.artist;
    _initializeAudioFiles = _getArtistAlbums(_artist);
  }

  Future<void> _getArtistAlbums(ArtistModel artist) async {
    var albums = <AlbumModel>[];
    // albums = await _audioQuery.getAlbumsFromArtist(artist: artist.name!);
    setState(() => _albums = albums);
  }

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: _initializeAudioFiles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SelectedArtist(artist: _artist, albums: _albums);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
}
