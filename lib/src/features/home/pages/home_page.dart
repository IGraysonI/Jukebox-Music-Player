import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/debug_instruments/debug_instruments.dart';
import '../../../common/debug_instruments/instruments_configurator.dart';
import '../../../common/extensions/build_context_extensions.dart';
import '../../../common/utils/player_utils.dart';
import '../../../common/widgets/space.dart';
import '../../../core/firebase/firebase_crashlytics_wrapper.dart';
import '../../albums/page/albums_page.dart';
import '../../artists/page/artists_page.dart';
import '../../audio_query/bloc/audio_query_bloc.dart';
import '../../audio_query/scope/audio_query_root_scope.dart';
import '../../music_player/widgets/player.dart';
import '../../songs/page/songs_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static String page() => 'HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedNavigatorIndex = 0;

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

  void _onItemTapped(int index) =>
      setState(() => _selectedNavigatorIndex = index);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Jukebox'),
          actions: [
            if (kDebugMode)
              const IconButton(
                onPressed: FirebaseCrashlyticsWrapper.crash,
                icon: Icon(Icons.bug_report_rounded),
              ),
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
            if (state.isProcessing) {
              //TODO: Добавить кастомный экран загрузки
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    Space.sm(),
                    const Text('Идёт загрузка ваших аудио файлов'),
                  ],
                ),
              );
            } else {
              return _NavigationDestinationView(
                selectedIndex: _selectedNavigatorIndex,
              );
            }
          },
        ),
        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: playerExpandProgress,
          builder: (BuildContext context, double height, Widget? child) {
            final value = PlayerUtils.percentageFromValueInRange(
              max: MediaQuery.of(context).size.height,
              min: PlayerUtils.playerMinHeight,
              value: height,
            );
            final navigationBarHeight =
                const NavigationBarThemeData().height ?? 80;

            var opacity = 1 - value;
            if (opacity < 0) opacity = 0;
            if (opacity > 1) opacity = 1;

            return SizedBox(
              height: navigationBarHeight - navigationBarHeight * value,
              child: Transform.translate(
                offset: Offset(0, navigationBarHeight * value * 0.5),
                child: Opacity(
                  opacity: opacity,
                  child: OverflowBox(
                    maxHeight: navigationBarHeight,
                    child: child,
                  ),
                ),
              ),
            );
          },
          child: NavigationBar(
            onDestinationSelected: _onItemTapped,
            selectedIndex: _selectedNavigatorIndex,
            destinations: _navigationBarItems,
          ),
        ),
      );
}

class _NavigationDestinationView extends StatelessWidget {
  const _NavigationDestinationView({required this.selectedIndex, Key? key})
      : super(key: key);

  final int selectedIndex;

  Widget _buildBody(BuildContext context) {
    switch (selectedIndex) {
      case 0:
        return SongsPage(
          songs:
              AudioQueryRooyScope.stateOf(context)!.audioQueryBloc.state.songs,
        );
      case 1:
        return AlbumsPage(
          albums:
              AudioQueryRooyScope.stateOf(context)!.audioQueryBloc.state.albums,
          isScrollable: true,
        );
      case 2:
        return ArtistsPage(
          artists: AudioQueryRooyScope.stateOf(context)!
              .audioQueryBloc
              .state
              .artists,
        );
      default:
        return Center(child: Text('Для $selectedIndex ничего нет'));
    }
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [_buildBody(context), const DetailedPlayer()],
      );
}
