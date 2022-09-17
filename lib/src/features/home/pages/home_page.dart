import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../../../common/const/app_strings.dart';
import '../../albums/screen/album_list_screen.dart';
import '../../music_player/pages/music_player.dart';
import '../../songs/screen/songs_list_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static String page() => 'HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  List<SongInfo> _songs = [];
  List<AlbumInfo> _albums = [];
  List<ArtistInfo> _artists = [];
  int _selectedIndex = 0;
  int _currentIndex = 0;
  final GlobalKey<MusicPlayerState> key = GlobalKey();

  @override
  void initState() {
    initializeAudioFiles();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final List<BottomNavigationBarItem> _bottomNavigationBarItems =
      const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.audiotrack_rounded),
      label: Strings.rSongsTitle,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.album_rounded),
      label: Strings.rAlbumsTitle,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle_rounded),
      label: Strings.rArtistsTitle,
    ),
  ];

  Future<void> initializeAudioFiles() async {
    _songs = await audioQuery.getSongs();
    _albums = await audioQuery.getAlbums();
    _artists = await audioQuery.getArtists();
    setState(() {
      _songs = _songs;
      _albums = _albums;
      _artists = _artists;
    });
  }

  void changeTrack({bool isNext = false}) {
    if (isNext) {
      if (_currentIndex != _songs.length - 1) {
        setState(() {
          _currentIndex++;
        });
      }
    } else {
      if (_currentIndex != 0) {
        setState(() {
          _currentIndex--;
        });
      }
    }
    key.currentState!.setSong(_songs[_currentIndex]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.rAppTitle),
        // actions: [if (kDebugMode)],
      ),
      body: _NavigationDestinationView(
        songs: _songs,
        albums: _albums,
        selectedIndex: _selectedIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavigationBarItems,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class _NavigationDestinationView extends StatelessWidget {
  const _NavigationDestinationView({
    required this.selectedIndex,
    required this.albums,
    required this.songs,
    Key? key,
  }) : super(key: key);

  final int selectedIndex;
  final List<SongInfo> songs;
  final List<AlbumInfo> albums;

  Widget _buildBody() {
    switch (selectedIndex) {
      case 0:
        return SongsListScreen(
          songs: songs,
        );
      case 1:
        return AlbumListScreen(albums: albums);
      case 2:
        return Container();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
