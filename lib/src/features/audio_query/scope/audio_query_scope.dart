import 'package:flutter/material.dart';

import '../controller/audio_query_controller.dart';
import '../data/audio_query_repository.dart';

/// AudioQueryScope widget.
class AudioQueryScope extends StatefulWidget {
  /// {@macro audio_query_root_scope}
  const AudioQueryScope({
    required this.child,
    super.key,
  });

  final Widget child;

  /// AudioQuery controller of the AudioQuery scope
  static AudioQueryController controllerOf(BuildContext context) =>
      _InheritedAudioQueryScope.of(context, listen: false).controller;

  @override
  State<AudioQueryScope> createState() => _AudioQueryScopeState();
}

class _AudioQueryScopeState extends State<AudioQueryScope> {
  late final AudioQueryController _audioQueryController;

  @override
  void initState() {
    super.initState();
    _audioQueryController = AudioQueryController(
      audioQueryRepository: AudioQueryRepositoryImpl(),
    );
  }

  @override
  void dispose() {
    _audioQueryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _InheritedAudioQueryScope(
        controller: _audioQueryController,
        child: widget.child,
      );
}

/// Inherited widget for quick access in the element tree.
class _InheritedAudioQueryScope extends InheritedWidget {
  const _InheritedAudioQueryScope({
    required this.controller,
    required super.child,
  });

  final AudioQueryController controller;

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  /// For example: `AudioQueryScope.maybeOf(context)`
  static _InheritedAudioQueryScope? maybeOf(
    BuildContext context, {
    bool listen = true,
  }) =>
      listen
          ? context
              .dependOnInheritedWidgetOfExactType<_InheritedAudioQueryScope>()
          : context.getInheritedWidgetOfExactType<_InheritedAudioQueryScope>();

  static Never _notFoundInheritedWidgetOfExactType() => throw ArgumentError(
        'Out of scope, not found inherited widget '
            'a _InheritedAudioQueryScope of the exact type',
        'out_of_scope',
      );

  /// The state from the closest instance of this class
  /// that encloses the given context.
  /// For example: `AudioQueryScope.of(context)`
  static _InheritedAudioQueryScope of(
    BuildContext context, {
    bool listen = true,
  }) =>
      maybeOf(context, listen: listen) ?? _notFoundInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(covariant _InheritedAudioQueryScope oldWidget) =>
      !identical(controller, oldWidget.controller);
}
