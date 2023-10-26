import 'package:go_router/go_router.dart';

import '../../features/home/pages/home_page.dart';
import 'application_navigation_observer.dart';

/// Роутер приложения
class ApplicationNavigation {
  ApplicationNavigation()
      : _router = GoRouter(
          observers: [ApplicationNavigationObserver()],
          initialLocation: '/${HomePage.page()}',
          routes: <GoRoute>[
            GoRoute(
              name: HomePage.page(),
              path: '/${HomePage.page()}',
              builder: (context, state) => const HomePage(),
              routes: const <GoRoute>[],
            ),
          ],
        );

  /// Доступ к роутеру приложения
  GoRouter get router => _router;
  final GoRouter _router;
}
