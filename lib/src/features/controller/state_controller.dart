import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:jukebox_music_player/src/features/controller/controller.dart';

/// State controller.
abstract interface class IStateController<State extends Object> implements IController {
  /// The current state of the controller.
  State get state;
}

/// State controller.
abstract base class StateController<State extends Object> extends Controller implements IStateController<State> {
  /// State controller.
  StateController({required State initialState}) : _$state = initialState;

  @override
  @nonVirtual
  State get state => _$state;
  State _$state;

  @protected
  @nonVirtual
  void setState(State state) {
    runZonedGuarded<void>(
      () => Controller.observer?.onStateChange(this, _$state, state),
      (error, stack) {},
    );
    _$state = state;
    if (isDisposed) return;
    notifyListeners();
  }
}
