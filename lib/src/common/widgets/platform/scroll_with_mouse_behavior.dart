import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

@immutable

/// {@template scroll_with_mouse_behavior}
/// ScrollWithMouseBehavior widget.
/// {@endtemplate}
class ScrolWithMouseBehavior extends MaterialScrollBehavior {
  const ScrolWithMouseBehavior();

  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
      };
}
