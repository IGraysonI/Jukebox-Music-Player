import 'package:flutter/material.dart';

class AudioQueryRooyScope extends StatefulWidget {
  const AudioQueryRooyScope({required this.child, super.key});

  final Widget child;

  static _AudioQueryRooyScopeState of(BuildContext context) =>
      context.findAncestorStateOfType<_AudioQueryRooyScopeState>()!;

  static _AudioQueryRooyScopeState? stateOf(BuildContext context) => (context
          .getElementForInheritedWidgetOfExactType<
              _InheritedAudioQueryRootScope>()
          ?.widget as _InheritedAudioQueryRootScope?)
      ?.state;

  @override
  State<AudioQueryRooyScope> createState() => _AudioQueryRooyScopeState();
}

class _AudioQueryRooyScopeState extends State<AudioQueryRooyScope> {
  // AudioQueryBloc? _audioQueryBloc;

  // AudioQueryBloc get audioQueryBloc => _audioQueryBloc!;

  @override
  void didChangeDependencies() {
    // _audioQueryBloc = AudioQueryBloc(audioQueryRepository:
    // AudioQueryRepository());
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // _audioQueryBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      _InheritedAudioQueryRootScope(state: this, child: widget.child);
}

/// Инхеритит виджет для быстрого доступа в древе виджетов
class _InheritedAudioQueryRootScope extends InheritedWidget {
  const _InheritedAudioQueryRootScope({
    required this.state,
    required super.child,
  });

  final _AudioQueryRooyScopeState state;

  @override
  bool updateShouldNotify(_InheritedAudioQueryRootScope oldWidget) =>
      state != oldWidget.state;
}
