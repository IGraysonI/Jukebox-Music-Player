import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:jukebox_music_player/features/albums/presentation/screen/album_list_screen.dart';
import 'package:jukebox_music_player/features/songs/presentation/screen/songs_list_screen.dart';
import 'package:jukebox_music_player/resource/app_strings.dart';
import 'package:jukebox_music_player/screens/music_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  List<SongInfo> songs = [];
  List<AlbumInfo> albums = [];
  List<ArtistInfo> artists = [];
  int _selectedIndex = 0;
  int _currentIndex = 0;
  final GlobalKey<MusicPlayerState> key = GlobalKey();

  @override
  void initState() {
    initializeAudioFiles();
    super.initState();
  }

  void initializeAudioFiles() async {
    songs = await audioQuery.getSongs();
    albums = await audioQuery.getAlbums();
    artists = await audioQuery.getArtists();
    setState(() {
      songs = songs;
      albums = albums;
      artists = artists;
    });
  }

  void changeTrack(bool isNext) {
    if (isNext) {
      if (_currentIndex != songs.length - 1) {
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
    key.currentState!.setSong(songs[_currentIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.rAppTitle),
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.audiotrack_rounded), label: Strings.rSongsTitle),
          BottomNavigationBarItem(
              icon: Icon(Icons.album_rounded), label: Strings.rAlbumsTitle),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: Strings.rArtistsTitle),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return SongsListScreen(
          songs: songs,
          changeTrack: changeTrack,
          musicPlayerKey: key,
        );
      case 1:
        return AlbumListScreen(albums: albums);
      case 2:
        return _artists();
      default:
        return Container();
    }
  }

  Widget _artists() {
    return ListView.builder(
      itemCount: artists.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(artists[index].name!),
        );
      },
    );
  }
}
