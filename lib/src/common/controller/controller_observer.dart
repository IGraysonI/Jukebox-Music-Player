import 'package:l/l.dart';

import 'package:jukebox_music_player/src/common/controller/controller.dart';

class ControllerObserver implements IControllerObserver {
  @override
  void onCreate(IController controller) {
    l.v6('Controller | ${controller.runtimeType} | Created');
  }

  @override
  void onDispose(IController controller) {
    l.v5('Controller | ${controller.runtimeType} | Disposed');
  }

  @override
  void onError(IController controller, Object error, StackTrace stackTrace) {
    l.w('Controller | ${controller.runtimeType} | $error, $stackTrace');
  }

  @override
  void onStateChange(
    IController controller,
    Object previousState,
    Object nextState,
  ) {
    l.d('''Controller | ${controller.runtimeType} | $previousState -> $nextState''');
  }
}
