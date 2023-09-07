import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/debug_instruments/debug_instruments.dart';
import '../../../common/debug_instruments/instruments_configurator.dart';
import '../../../common/extensions/build_context_extensions.dart';
import '../../../common/widgets/space.dart';
import '../../albums/page/albums_page.dart';
import '../../artists/page/artists_page.dart';
import '../../audio_query/bloc/audio_query_bloc.dart';
import '../../audio_query/scope/audio_query_root_scope.dart';
import '../../songs/page/songs_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static String page() => 'HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    AudioQueryRooyScope.getAudioFiles(context);
    super.initState();
  }

  @override
  void dispose() => super.dispose();

  List<NavigationDestination> get _navigationBarItems =>
      const <NavigationDestination>[
        NavigationDestination(
          icon: Icon(Icons.audiotrack_rounded),
          label: 'Songs',
        ),
        NavigationDestination(
          icon: Icon(Icons.album_rounded),
          label: 'Albums',
        ),
        NavigationDestination(
          icon: Icon(Icons.account_circle_rounded),
          label: 'Artists',
        ),
      ];

  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jukebox'),
        actions: [
          if (kDebugMode)
            DebugInstruments(
              instrumentConfigurator: InstrumentConfigurator(
                sharedPreferences: context.cache.sharedPreferences,
              ),
            ),
        ],
      ),
      body: BlocBuilder<AudioQueryBloc, AudioQueryState>(
        bloc: AudioQueryRooyScope.stateOf(context)!.audioQueryBloc,
        builder: (context, state) {
          if (state is AudioQueryData) {
            return _NavigationDestinationView(
              songs: state.songs,
              albums: state.albums,
              artists: state.artists,
              selectedIndex: _selectedIndex,
            );
          } else {
            //TODO: Добавить кастомный экран загрузки
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(color: Colors.white),
                  Space.sm(),
                  const Text('Идёт загрузка ваших аудио файлов'),
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: _onItemTapped,
        selectedIndex: _selectedIndex,
        destinations: _navigationBarItems,
      ),
    );
  }
}

class _NavigationDestinationView extends StatelessWidget {
  const _NavigationDestinationView({
    required this.selectedIndex,
    required this.songs,
    required this.albums,
    required this.artists,
    Key? key,
  }) : super(key: key);

  final int selectedIndex;
  final List<SongInfo> songs;
  final List<AlbumInfo> albums;
  final List<ArtistInfo> artists;

  Widget _buildBody() {
    switch (selectedIndex) {
      case 0:
        return SongsPage(songs: songs);
      case 1:
        return AlbumsPage(albums: albums, isScrollable: true);
      case 2:
        return ArtistsPage(artists: artists);
      default:
        return Center(child: Text('Для $selectedIndex ничего нет'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
