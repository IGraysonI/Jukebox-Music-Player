import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/common/util/player_util.dart';
import 'package:jukebox_music_player/src/features/music_player/enum/panel_state_enum.dart';

/// Type definition for the builder function
typedef MiniplayerBuilder = Widget Function(double height, double percentage);

/// {@template miniplayer}
/// A miniplayer widget that can be dragged up and down.
/// {@endtemplate}
class Miniplayer extends StatefulWidget {
  const Miniplayer({
    required this.minHeight,
    required this.maxHeight,
    required this.builder,
    this.curve = Curves.easeOut,
    this.elevation = 0,
    this.backgroundColor,
    this.duration = const Duration(milliseconds: 300),
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

  /// Used to set the color of the background box shadow
  final Color backgroundBoxShadow;

  @override
  MiniplayerState createState() => MiniplayerState();
}

class MiniplayerState extends State<Miniplayer> with TickerProviderStateMixin {
  final ValueNotifier<double> _dragDownPercentage = ValueNotifier(0);
  final StreamController<double> _heightController =
      StreamController<double>.broadcast();
  late ValueNotifier<double> _heightNotifier;

  /// Current y position of drag gesture
  late double _dragHeight;

  /// Used to determine SnapPosition
  late double _startHeight;

  AnimationController? _animationController;

  bool animating = false;

  /// Counts how many updates were required for a distance (onPanUpdate) ->
  /// necessary to calculate the drag speed
  int updateCount = 0;

  @override
  void initState() {
    super.initState();

    _heightNotifier = playerExpandProgress;
    _resetAnimationController();
    _dragHeight = _heightNotifier.value;
    // if (widget.controller != null) {
    //   widget.controller!.addListener(controllerListener);
    // }
  }

  @override
  void dispose() {
    _heightController.close();
    _animationController?.dispose();
    // widget.controller?.removeListener(controllerListener);

    super.dispose();
  }

  void _statusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) _resetAnimationController();
  }

  void _resetAnimationController({Duration? duration}) {
    _animationController?.dispose();
    _animationController = AnimationController(
      vsync: this,
      duration: duration ?? widget.duration,
    );
    _animationController!.addStatusListener(_statusListener);
    animating = false;
  }

  /// Determines whether the panel should be updated in height or discarded
  void _handleHeightChange({bool animation = false}) {
    if (_dragHeight >= widget.minHeight) {
      if (_dragDownPercentage.value != 0) {
        _dragDownPercentage.value = 0;
      }
      if (_dragHeight > widget.maxHeight) return;
      _heightNotifier.value = _dragHeight;
    }
  }

  /// Animates the panel height according to a SnapPoint
  void _snapToPosition(PanelStateEnum snapPosition) => switch (snapPosition) {
        PanelStateEnum.max => _animateToHeight(widget.maxHeight),
        PanelStateEnum.min => _animateToHeight(widget.minHeight)
      };

  /// Animates the panel height to a specific value
  void _animateToHeight(final double height, {Duration? duration}) {
    if (_animationController == null) return;
    final startHeight = _dragHeight;
    if (duration != null) {
      _resetAnimationController(duration: duration);
    }
    final sizeAnimation = Tween(
      begin: startHeight,
      end: height,
    ).animate(
      CurvedAnimation(parent: _animationController!, curve: widget.curve),
    );
    sizeAnimation.addListener(
      () {
        if (sizeAnimation.value == startHeight) return;
        _dragHeight = sizeAnimation.value;
        _handleHeightChange(animation: true);
      },
    );
    animating = true;
    _animationController!.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: _heightNotifier,
        builder: (context, height, _) {
          final percentage = (height - widget.minHeight) /
              (widget.maxHeight - widget.minHeight);
          return Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: height,
              child: GestureDetector(
                onTap: () => _snapToPosition(
                  _dragHeight != widget.maxHeight
                      ? PanelStateEnum.max
                      : PanelStateEnum.min,
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
                  final speed =
                      (_dragHeight - _startHeight * _dragHeight < _startHeight
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
                  var snap = PanelStateEnum.min;
                  final percentageMax = PlayerUtil.percentageFromValueInRange(
                    min: widget.minHeight,
                    max: widget.maxHeight,
                    value: _dragHeight,
                  );

                  /// Started from expanded state
                  if (_startHeight > widget.minHeight) {
                    if (percentageMax > 1 - snapPercentage) {
                      snap = PanelStateEnum.max;
                    }
                  }

                  /// Started from minified state
                  else {
                    snap = PanelStateEnum.max;
                  }

                  /// Snap to position
                  _snapToPosition(snap);
                },
                onPanUpdate: (details) {
                  _dragHeight -= details.delta.dy;
                  updateCount++;
                  _handleHeightChange();
                },
                child: ValueListenableBuilder(
                  valueListenable: _dragDownPercentage,
                  builder: (context, value, child) => Opacity(
                    opacity: PlayerUtil.borderDouble(
                      minRange: 0,
                      maxRange: 1,
                      value: 1 - value * 0.8,
                    ),
                    child: Transform.translate(
                      offset: Offset(0, widget.minHeight * value * 0.5),
                      child: child,
                    ),
                  ),
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
            ),
          );
        },
      );
}
