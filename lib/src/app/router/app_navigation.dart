import 'package:go_router/go_router.dart';

import '../../features/home/pages/home_screen.dart';
import 'app_navigation_observer.dart';

/// Роутер приложения
class AppNavigation {
  AppNavigation()
      : _router = GoRouter(
          observers: [AppNavigationObserver()],
          initialLocation: '/',
          routes: <GoRoute>[
            GoRoute(
              name: HomeScreen.page(),
              path: HomeScreen.page(),
              builder: (context, state) => const HomeScreen(),
            )
          ],
        );

  /// Доступ к роутеру приложения
  GoRouter get router => _router;
  final GoRouter _router;
}
