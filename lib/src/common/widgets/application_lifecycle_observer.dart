// ignore_for_file: unused_element

import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:l/l.dart';

class ApplicationLifecycleObserver extends StatefulWidget {
  const ApplicationLifecycleObserver({required this.child, super.key});

  final Widget child;

  @override
  State<ApplicationLifecycleObserver> createState() =>
      ApplicationLifecycleObserverState();

  static ApplicationLifecycleObserverState of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_InheritedStateContainer>()!
      .data;
}

class ApplicationLifecycleObserverState
    extends State<ApplicationLifecycleObserver> {
  final _lifecycleCallbacks = <ApplicationLifecycleCallback>[];
  AppLifecycleListener? _listener;

  @override
  void initState() {
    _listener = AppLifecycleListener(
      onShow: _handleTransition,
      onResume: _handleTransition,
      onInactive: _handleTransition,
      onPause: _handleTransition,
      onHide: _handleTransition,
      onDetach: _handleTransition,
      onRestart: _handleTransition,
      onStateChange: _handleStateChange,
    );

    super.initState();
  }

  @override
  void dispose() {
    _listener?.dispose();
    super.dispose();
  }

  void _handleTransition({List<VoidCallback>? callbacks}) {
    final state = SchedulerBinding.instance.lifecycleState;

    for (final callback in _lifecycleCallbacks) {
      callback.call(state!);
    }
  }

  void _handleStateChange(AppLifecycleState state) =>
      l.w('State Change $state');

  void addLifecycleCallback(ApplicationLifecycleCallback callback) =>
      _lifecycleCallbacks.add(callback);

  void resetCallbacks() => _lifecycleCallbacks.clear();

  @override
  Widget build(BuildContext context) => _InheritedStateContainer(
        data: this,
        child: widget.child,
      );
}

class _InheritedStateContainer extends InheritedWidget {
  const _InheritedStateContainer({
    required this.data,
    required super.child,
    super.key,
  });

  final ApplicationLifecycleObserverState data;

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => data != old.data;
}

class ApplicationLifecycleCallback {
  ApplicationLifecycleCallback({
    this.onResumed,
    this.onPaused,
    this.onInactive,
    this.onDetached,
    this.onHidden,
    this.debugLabel = '',
  });

  final VoidCallback? onResumed;
  final VoidCallback? onPaused;
  final VoidCallback? onInactive;
  final VoidCallback? onDetached;
  final VoidCallback? onHidden;
  final String? debugLabel;
  int _counter = 0;

  int get executedTimes => _counter;

  void call(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (onResumed != null) l.i('execute onResumed callback [$debugLabel]');
        onResumed?.call();
        break;
      case AppLifecycleState.inactive:
        if (onInactive != null) {
          l.i('execute onInactive callback [$debugLabel]');
        }
        onInactive?.call();
        break;
      case AppLifecycleState.paused:
        if (onPaused != null) l.i('execute onPaused callback [$debugLabel]');
        onPaused?.call();
        break;
      case AppLifecycleState.detached:
        if (onDetached != null) {
          l.i('execute onDetached callback [$debugLabel]');
        }
        onDetached?.call();
        break;
      case AppLifecycleState.hidden:
        if (onHidden != null) {
          l.i('execute onDetached callback [$debugLabel]');
        }
        onDetached?.call();
        break;
    }
  }

  void callSequence() {
    l.i('execute callSequence [$debugLabel]');
    onInactive?.call();
    onPaused?.call();
    onResumed?.call();
    onDetached?.call();
    _counter++;
  }

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApplicationLifecycleCallback &&
          runtimeType == other.runtimeType &&
          onResumed == other.onResumed &&
          onPaused == other.onPaused &&
          onInactive == other.onInactive &&
          onDetached == other.onDetached;

  @override
  // ignore: avoid_equals_and_hash_code_on_mutable_classes
  int get hashCode =>
      onResumed.hashCode ^
      onPaused.hashCode ^
      onInactive.hashCode ^
      onDetached.hashCode;
}
