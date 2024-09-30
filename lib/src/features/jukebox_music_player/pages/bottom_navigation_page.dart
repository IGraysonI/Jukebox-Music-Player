import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jukebox_music_player/src/common/utils/player_util.dart';
import 'package:jukebox_music_player/src/features/music_player/widgets/music_player.dart';
import 'package:jukevault/jukevault.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({required this.child, super.key});

  final StatefulNavigationShell child;

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  late final Jukevault _jukevault;
  bool _hasPermission = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _jukevault = Jukevault();
  }

  // TODO: Implement better permission handling
  void _checkPermisison() async {
    // Check if the plugin has permission to read the library.
    try {
      _hasPermission = await _jukevault.permissionsStatus();

      // If [permissionsStatus] is called from [Web] or [Desktop] platforms,
      // will throw a [UnimplementedError]. So, we'll use this to disable
      // the grant buttton.
    } on UnimplementedError {
      _hasError = true;

      // Some went wrong.
    } catch (e) {
      _hasPermission = false;
    }
  }

  void requestPermission(BuildContext context) => () async {
        bool r = _hasPermission ? true : await _jukevault.permissionsRequest();
        if (!context.mounted) return;
        SnackBar snackBar = SnackBar(
          content: Row(
            children: [
              Icon(r ? Icons.done : Icons.error_outline_rounded),
              const SizedBox(width: 18),
              Text(
                r ? 'The plugin has permission!' : 'The plugin has no permission!',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
          backgroundColor: r ? Colors.green : Colors.red,
        );
        if (!context.mounted) return;
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      };

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: playerExpandProgress,
        builder: (BuildContext context, double height, Widget? child) {
          final value = PlayerUtil.percentageFromValueInRange(
            max: MediaQuery.of(context).size.height,
            min: PlayerUtil.playerMinHeight,
            value: height,
          );
          final navigationBarHeight = const NavigationBarThemeData().height ?? 80;
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
          selectedIndex: widget.child.currentIndex,
          onDestinationSelected: (index) => setState(
            () => widget.child.goBranch(
              index,
              initialLocation: index == widget.child.currentIndex,
            ),
          ),
          destinations: const [
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
          ],
        ),
      ),
      body:
          // _hasPermission
          //     ?
          Stack(
        children: [
          SafeArea(child: widget.child),
          const MusicPlayer(),
        ],
      )
      // : Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         ElevatedButton(
      //           onPressed: () => requestPermission(context),
      //           child: const Text('Grant Permission'),
      //         ),
      //         if (_hasError) const Text('This feature is not available on Web/Desktop'),
      //       ],
      //     ),
      //   ),
      );
}
