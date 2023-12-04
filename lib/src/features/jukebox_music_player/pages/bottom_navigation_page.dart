import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/utils/player_util.dart';
import '../../music_player/widgets/detailed_player.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({required this.child, super.key});

  final StatefulNavigationShell child;

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
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
            // BlocBuilder<AudioQueryBloc, AudioQueryState>(
            //   bloc: AudioQueryRooyScope.of(context).audioQueryBloc,
            //   builder: (context, state) {
            //     if (state.isProcessing) {
            //       return const Center(child: CircularProgressIndicator());
            //     } else {
            // return
            Stack(
          children: [
            SafeArea(child: widget.child),
            const DetailedPlayer(),
          ],
          // );
          // }
          // },
        ),
      );
}
