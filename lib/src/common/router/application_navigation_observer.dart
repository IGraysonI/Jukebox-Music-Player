import 'package:flutter/widgets.dart';
import 'package:l/l.dart';

/// Application navigation observer.
class ApplicationNavigatorObserver<T> extends NavigatorObserver {
  String get _nav => '[$T]';

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      l.d('$_nav push: ${previousRoute?.name} -> ${route.name}');

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      l.d('$_nav didPop: ${previousRoute?.name} <- ${route.name}');

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) => l.d(
        '$_nav didRemove: ${route.name}, previousRoute= ${previousRoute?.name}',
      );

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) =>
      l.d('$_nav didReplace: new= ${newRoute?.name}, old= ${oldRoute?.name}');

  @override
  void didStartUserGesture(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) =>
      l.d(
        'didStartUserGesture: ${route.name}, '
        'previousRoute= ${previousRoute?.name}',
      );

  @override
  void didStopUserGesture() => l.d('didStopUserGesture');
}

extension on Route<dynamic> {
  String get name => '[${settings.name}]';
}
