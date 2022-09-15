import 'package:go_router/go_router.dart';

import '../../features/home/pages/home_page.dart';
import 'app_navigation_observer.dart';

/// Роутер приложения
class AppNavigation {
  AppNavigation()
      : _router = GoRouter(
          observers: [AppNavigationObserver()],
          initialLocation: '/${HomePage.page()}',
          routes: <GoRoute>[
            GoRoute(
              name: HomePage.page(),
              path: '/${HomePage.page()}',
              builder: (context, state) => const HomePage(),
              routes: <GoRoute>[],
            )
          ],
        );

  /// Доступ к роутеру приложения
  GoRouter get router => _router;
  final GoRouter _router;
}
