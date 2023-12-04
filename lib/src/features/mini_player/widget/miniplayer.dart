library miniplayer;

import 'dart:async';

import 'package:flutter/material.dart';

import '../../../common/utils/player_util.dart';
import '../controller/mini_player_controller.dart';
import '../scope/miniplayer_will_pop_scope.dart';

/// Type definition for the builder function
typedef MiniplayerBuilder = Widget Function(double height, double percentage);

/// Type definition for onDismiss. Will be used in a future version.
typedef DismissCallback = void Function(double percentage);

/// Miniplayer class
class Miniplayer extends StatefulWidget {
  const Miniplayer({
    required this.minHeight,
    required this.maxHeight,
    required this.builder,
    this.curve = Curves.easeOut,
    this.elevation = 0,
    this.backgroundColor,
    this.valueNotifier,
    this.duration = const Duration(milliseconds: 300),
    this.onDismissed,
    this.controller,
    this.backgroundBoxShadow = Colors.black45,
    super.key,
  });

  /// Required option to set the minimum height
  final double minHeight;

  /// Required option to set the maximum height
  final double maxHeight;

  /// Option to enable and set elevation for the miniplayer
  final double elevation;

  /// Central API-Element
  /// Provides a builder with useful information
  final MiniplayerBuilder builder;

  /// Option to set the animation curve
  final Curve curve;

  /// Sets the background-color of the miniplayer
  final Color? backgroundColor;

  /// Option to set the animation duration
  final Duration duration;

  /// Allows you to use a global ValueNotifier with the current progress.
  /// This can be used to hide the BottomNavigationBar.
  final ValueNotifier<double>? valueNotifier;

  /// If onDismissed is set, the miniplayer can be dismissed
  final Function? onDismissed;

  /// Allows you to manually control the miniplayer in code
  final MiniplayerController? controller;

  /// Used to set the color of the background box shadow
  final Color backgroundBoxShadow;

  @override
  _MiniplayerState createState() => _MiniplayerState();
}

class _MiniplayerState extends State<Miniplayer> with TickerProviderStateMixin {
  final ValueNotifier<double> _dragDownPercentage = ValueNotifier(0);
  final StreamController<double> _heightController =
      StreamController<double>.broadcast();
  late ValueNotifier<double> _heightNotifier;

  /// Current y position of drag gesture
  late double _dragHeight;

  /// Used to determine SnapPosition
  late double _startHeight;

  AnimationController? _animationController;

  /// Temporary variable as long as onDismiss is deprecated. Will be removed in
  /// a future version.
  Function? onDismissed;

  bool dismissed = false;
  bool animating = false;

  /// Counts how many updates were required for a distance (onPanUpdate) ->
  /// necessary to calculate the drag speed
  int updateCount = 0;

  @override
  void initState() {
    if (widget.valueNotifier == null) {
      _heightNotifier = ValueNotifier(widget.minHeight);
    } else {
      _heightNotifier = widget.valueNotifier!;
    }

    _resetAnimationController();

    _dragHeight = _heightNotifier.value;

    if (widget.controller != null) {
      widget.controller!.addListener(controllerListener);
    }

    if (widget.onDismissed != null) {
      onDismissed = widget.onDismissed;
    }

    super.initState();
  }

  @override
  void dispose() {
    _heightController.close();

    if (_animationController != null) {
      _animationController!.dispose();
    }

    if (widget.controller != null) {
      widget.controller!.removeListener(controllerListener);
    }

    super.dispose();
  }

  void _statusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) _resetAnimationController();
  }

  void _resetAnimationController({Duration? duration}) {
    if (_animationController != null) {
      _animationController!.dispose();
    }

    _animationController = AnimationController(
      vsync: this,
      duration: duration ?? widget.duration,
    );

    _animationController!.addStatusListener(_statusListener);

    animating = false;
  }

  /// Determines whether the panel should be updated in height or discarded
  void _handleHeightChange({bool animation = false}) {
    /// Drag above minHeight
    if (_dragHeight >= widget.minHeight) {
      if (_dragDownPercentage.value != 0) {
        _dragDownPercentage.value = 0;
      }

      if (_dragHeight > widget.maxHeight) return;

      _heightNotifier.value = _dragHeight;
    }

    /// Drag below minHeight
    else if (onDismissed != null) {
      final percentageDown = PlayerUtils.borderDouble(
        minRange: 0,
        maxRange: 1,
        value: PlayerUtils.percentageFromValueInRange(
          min: widget.minHeight,
          max: 0,
          value: _dragHeight,
        ),
      );

      if (_dragDownPercentage.value != percentageDown) {
        _dragDownPercentage.value = percentageDown;
      }

      if (percentageDown >= 1 && animation && !dismissed) {
        if (onDismissed != null) {
          // ignore: avoid_dynamic_calls
          onDismissed?.call();
        }
        setState(() => dismissed = true);
      }
    }
  }

  /// Animates the panel height according to a SnapPoint
  void _snapToPosition(PanelState snapPosition) {
    switch (snapPosition) {
      case PanelState.max:
        _animateToHeight(widget.maxHeight);
        return;
      case PanelState.min:
        _animateToHeight(widget.minHeight);
        return;
      case PanelState.dismiss:
        _animateToHeight(0);
        return;
    }
  }

  /// Animates the panel height to a specific value
  void _animateToHeight(final double h, {Duration? duration}) {
    if (_animationController == null) return;
    final startHeight = _dragHeight;

    if (duration != null) {
      _resetAnimationController(duration: duration);
    }

    final sizeAnimation = Tween(
      begin: startHeight,
      end: h,
    ).animate(
      CurvedAnimation(parent: _animationController!, curve: widget.curve),
    );

    sizeAnimation.addListener(() {
      if (sizeAnimation.value == startHeight) return;

      _dragHeight = sizeAnimation.value;

      _handleHeightChange(animation: true);
    });

    animating = true;
    _animationController!.forward(from: 0);
  }

  /// Listener function for the controller
  void controllerListener() {
    if (widget.controller == null) return;
    if (widget.controller!.value == null) return;

    switch (widget.controller!.value!.height) {
      case -1:
        _animateToHeight(
          widget.minHeight,
          duration: widget.controller!.value!.duration,
        );
        break;
      case -2:
        _animateToHeight(
          widget.maxHeight,
          duration: widget.controller!.value!.duration,
        );
        break;
      case -3:
        _animateToHeight(
          0,
          duration: widget.controller!.value!.duration,
        );
        break;
      default:
        _animateToHeight(
          widget.controller!.value!.height.toDouble(),
          duration: widget.controller!.value!.duration,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (dismissed) {
      return Container();
    }

    return MiniplayerWillPopScope(
      onWillPop: () async {
        if (_heightNotifier.value > widget.minHeight) {
          _snapToPosition(PanelState.min);
          return false;
        }
        return true;
      },
      child: ValueListenableBuilder(
        valueListenable: _heightNotifier,
        builder: (BuildContext context, double height, Widget? _) {
          final percentage = (height - widget.minHeight) /
              (widget.maxHeight - widget.minHeight);
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              if (percentage > 0)
                GestureDetector(
                  onTap: () => _animateToHeight(widget.minHeight),
                  child: Opacity(
                    opacity: PlayerUtils.borderDouble(
                      minRange: 0,
                      maxRange: 1,
                      value: percentage,
                    ),
                    child: Container(color: widget.backgroundColor),
                  ),
                ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: height,
                  child: GestureDetector(
                    child: ValueListenableBuilder(
                      valueListenable: _dragDownPercentage,
                      builder:
                          (BuildContext context, double value, Widget? child) {
                        return Opacity(
                          opacity: PlayerUtils.borderDouble(
                            minRange: 0,
                            maxRange: 1,
                            value: 1 - value * 0.8,
                          ),
                          child: Transform.translate(
                            offset: Offset(0, widget.minHeight * value * 0.5),
                            child: child,
                          ),
                        );
                      },
                      child: Material(
                        child: Container(
                          constraints: const BoxConstraints.expand(),
                          decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: widget.backgroundBoxShadow,
                                blurRadius: widget.elevation,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            color: widget.backgroundColor ??
                                Theme.of(context).colorScheme.background,
                          ),
                          child: widget.builder(height, percentage),
                        ),
                      ),
                    ),
                    onTap: () => _snapToPosition(
                      _dragHeight != widget.maxHeight
                          ? PanelState.max
                          : PanelState.min,
                    ),
                    onPanStart: (details) {
                      _startHeight = _dragHeight;
                      updateCount = 0;

                      if (animating) {
                        _resetAnimationController();
                      }
                    },
                    onPanEnd: (details) async {
                      /// Calculates drag speed
                      final speed = (_dragHeight - _startHeight * _dragHeight <
                                  _startHeight
                              ? 1
                              : -1) /
                          updateCount *
                          100;

                      /// Define the percentage distance depending on the speed
                      /// with which the widget should snap
                      var snapPercentage = 0.005;
                      if (speed <= 4) {
                        snapPercentage = 0.2;
                      } else if (speed <= 9) {
                        snapPercentage = 0.08;
                      } else if (speed <= 50) {
                        snapPercentage = 0.01;
                      }

                      /// Determine to which SnapPosition the widget should snap
                      var snap = PanelState.min;

                      final percentageMax =
                          PlayerUtils.percentageFromValueInRange(
                        min: widget.minHeight,
                        max: widget.maxHeight,
                        value: _dragHeight,
                      );

                      /// Started from expanded state
                      if (_startHeight > widget.minHeight) {
                        if (percentageMax > 1 - snapPercentage) {
                          snap = PanelState.max;
                        }
                      }

                      /// Started from minified state
                      else {
                        if (percentageMax > snapPercentage) {
                          snap = PanelState.max;
                        }

                        /// DismissedPercentage > 0.2 -> dismiss
                        else if (onDismissed != null &&
                            PlayerUtils.percentageFromValueInRange(
                                  min: widget.minHeight,
                                  max: 0,
                                  value: _dragHeight,
                                ) >
                                snapPercentage) {
                          snap = PanelState.dismiss;
                        }
                      }

                      /// Snap to position
                      _snapToPosition(snap);
                    },
                    onPanUpdate: (details) {
                      if (dismissed) return;

                      _dragHeight -= details.delta.dy;
                      updateCount++;

                      _handleHeightChange();
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
