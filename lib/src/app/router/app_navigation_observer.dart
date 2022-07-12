import 'package:flutter/widgets.dart';

import '../../core/logger/l.dart';

class AppNavigationObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      l.i('Push: ${previousRoute?.name} -> ${route.name}');

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      l.i('Pop: ${previousRoute?.name} <- ${route.name}');

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      l.i('Remove: ${route.name}, previousRoute = ${previousRoute?.name}');

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) =>
      l.i('Replace: new = ${newRoute?.name} <- ${oldRoute?.name}');

  @override
  void didStartUserGesture(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) =>
      l.i(
        'StartUserGesture: ${route.name}, '
        'previousRoute =  ${previousRoute?.name}',
      );

  @override
  void didStopUserGesture() => l.i('StopUserGesture');
}

extension on Route<dynamic> {
  String get name => '[${settings.name}]';
}
