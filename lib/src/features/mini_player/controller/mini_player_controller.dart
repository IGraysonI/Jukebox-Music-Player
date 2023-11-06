import 'package:flutter/material.dart';

/// MiniplayerController class
class MiniplayerController extends ValueNotifier<ControllerData?> {
  MiniplayerController() : super(null);

  /// Animates to a given height or state(expanded, dismissed, ...)
  void animateToHeight({
    double? height,
    PanelState? state,
    Duration? duration,
  }) {
    if (height == null && state == null) {
      throw ArgumentError(
        'Miniplayer: One of the two parameters, height or status, is required.',
      );
    }

    if (height != null && state != null) {
      throw ArgumentError(
        '''Miniplayer: Only one of the two parameters, height or status, can be specified.''',
      );
    }

    final valBefore = value;

    if (state != null) {
      value = ControllerData(state.heightCode, duration);
    } else {
      if (height! < 0) return;

      value = ControllerData(height.round(), duration);
    }

    if (valBefore == value) {
      notifyListeners();
    }
  }
}

enum PanelState { max, min, dismiss }

//ControllerData class. Used for the controller
class ControllerData {
  const ControllerData(this.height, this.duration);
  final int height;
  final Duration? duration;
}

extension SelectedColorExtension on PanelState {
  int get heightCode {
    switch (this) {
      case PanelState.min:
        return -1;
      case PanelState.max:
        return -2;
      case PanelState.dismiss:
        return -3;
      default:
        return -1;
    }
  }
}
