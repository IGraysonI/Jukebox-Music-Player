import 'platform/keyboard_observer_interface.dart';
import 'platform/keyboard_observer_vm.dart';

sealed class KeyboardObserver {
  KeyboardObserver._();
  static IKeyboardObserver? _keyboardObserver;
  static IKeyboardObserver get instance =>
      _keyboardObserver ??= $getKeyboardObserver();
  static IKeyboardObserver get I => instance;
}
