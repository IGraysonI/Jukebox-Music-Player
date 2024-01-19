import 'package:meta/meta.dart';

/// Pattern matching for [StateBase].
typedef StateBaseMatch<R, T> = R Function(T state);

@immutable
abstract base class StateBase<T> {
  /// {@macro state_base}
  const StateBase({required this.message});

  /// Message or state description.
  @nonVirtual
  final String message;

  /// If an error has occurred.
  bool get hasError => maybeMap<bool>(orElse: () => false, error: (_) => true);

  /// Is in processing state.
  bool get isProcessing => maybeMap<bool>(orElse: () => false, processing: (_) => true);

  /// Is in idle state.
  bool get isIdle => !isProcessing;

  /// Pattern matching for state.
  R map<R>({
    required StateBaseMatch<R, T> idle,
    required StateBaseMatch<R, T> processing,
    required StateBaseMatch<R, T> successful,
    required StateBaseMatch<R, T> error,
  });

  /// Pattern matching for state.
  R maybeMap<R>({
    required R Function() orElse,
    StateBaseMatch<R, T> idle,
    StateBaseMatch<R, T> processing,
    StateBaseMatch<R, T> successful,
    StateBaseMatch<R, T> error,
  });

  /// Pattern matching for state.\
  R? mapOrNull<R>({
    StateBaseMatch<R, T> idle,
    StateBaseMatch<R, T> processing,
    StateBaseMatch<R, T> successful,
    StateBaseMatch<R, T> error,
  });

  /// Copy with method for state.
  StateBase<T> copyWith({
    String? message,
  });

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  String toString() {
    final buffer = StringBuffer()
      ..write('message: $message')
      ..write(')');
    return buffer.toString();
  }
}
