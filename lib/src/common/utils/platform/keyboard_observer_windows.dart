import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:win32/win32.dart' show GetKeyState;

import 'package:jukebox_music_player/src/common/utils/platform/keyboard_observer_interface.dart';

IKeyboardObserver $getKeyboardObserver$Windows() => _KeyboardObserver$Windows();

@sealed
class _KeyboardObserver$Windows
    with _IsKeyPressed, ChangeNotifier
    implements IKeyboardObserver {
  @override
  bool get isControlPressed =>
      isKeyPressed(VK.LCONTROL) || isKeyPressed(VK.RCONTROL);

  @override
  bool get isShiftPressed => isKeyPressed(VK.LSHIFT) || isKeyPressed(VK.RSHIFT);

  @override
  bool get isAltPressed => isKeyPressed(VK.LMENU) || isKeyPressed(VK.RMENU);

  @override
  bool get isMetaPressed => isKeyPressed(VK.LWIN) || isKeyPressed(VK.RWIN);
}

mixin _IsKeyPressed {
  /// Returns true if the given [VK] is pressed.
  bool isKeyPressed(VK key) {
    final state = GetKeyState(key.code);
    return state != 0 && state != 1;
  }
}
