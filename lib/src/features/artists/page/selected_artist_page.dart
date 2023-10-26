import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../widget/selected_artist.dart';

class SelectedArtistPage extends StatefulWidget {
  const SelectedArtistPage({required this.artist, super.key});

  final ArtistInfo artist;

  @override
  State<SelectedArtistPage> createState() => _SelectedArtistPageState();
}

class _SelectedArtistPageState extends State<SelectedArtistPage> {
  late final ArtistInfo _artist;
  late final List<AlbumInfo> _albums;
  final FlutterAudioQuery _audioQuery = FlutterAudioQuery();
  late Future<void> _initializeAudioFiles;

  @override
  void initState() {
    _artist = widget.artist;
    _initializeAudioFiles = _getArtistAlbums(_artist);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _getArtistAlbums(ArtistInfo artist) async {
    var albums = <AlbumInfo>[];
    albums = await _audioQuery.getAlbumsFromArtist(artist: artist.name!);
    setState(() => _albums = albums);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder(
        future: _initializeAudioFiles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SelectedArtist(artist: _artist, albums: _albums);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
