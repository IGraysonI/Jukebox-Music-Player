import 'package:flutter/widgets.dart';
import 'package:jukebox_music_player/src/common/router/bottom_navigation_guard.dart';
import 'package:jukebox_music_player/src/common/router/routes.dart';
import 'package:octopus/octopus.dart';

mixin RouterStateMixin<T extends StatefulWidget> on State<T> {
  late final Octopus router;
  late final ValueNotifier<List<({Object error, StackTrace stackTrace})>> errorsObserver;

  @override
  void initState() {
    super.initState();
    // Observe all errors.
    errorsObserver = ValueNotifier<List<({Object error, StackTrace stackTrace})>>(
      <({Object error, StackTrace stackTrace})>[],
    );

    // Create router.
    router = Octopus(
      routes: Routes.values,
      defaultRoute: Routes.bottomNavigation,
      transitionDelegate: const DefaultTransitionDelegate(),
      guards: [
        BottomNavigationGuard(),
      ],
      onError: (error, stackTrace) => errorsObserver.value = <({Object error, StackTrace stackTrace})>[
        (error: error, stackTrace: stackTrace),
        ...errorsObserver.value,
      ],
    );
  }
}
