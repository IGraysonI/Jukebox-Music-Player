import 'package:meta/meta.dart';

/// Pattern matching for [StateBase].
typedef StateBaseMatch<R, T> = R Function(T state);

abstract base class StateBase<T> {
  /// {@macro state_base}
  const StateBase({required this.message});

  /// Message or state description.
  @nonVirtual
  final String message;

  /// Error message.
  abstract final String? error;

  /// If an error has occurred?
  bool get hasError => error != null;

  /// Is in progress state?
  bool get isProcessing;

  /// Is in idle state?
  bool get isIdling => !isProcessing;

  /// Pattern matching for state.
  R map<R>({
    required StateBaseMatch<R, T> idle,
    required StateBaseMatch<R, T> processing,
  });

  /// Pattern matching for state.
  R maybeMap<R>({
    required R Function() orElse,
    required StateBaseMatch<R, T> idle,
    required StateBaseMatch<R, T> processing,
  });

  /// Pattern matching for state.\
  R? mapOrNull<R>({
    required StateBaseMatch<R, T> idle,
    required StateBaseMatch<R, T> processing,
  });

  /// Copy with method for state.
  StateBase<T> copyWith({
    String? message,
    String? error,
  });

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other);

  @override
  String toString() {
    final buffer = StringBuffer();
    if (error != null) buffer.write('error: $error, ');
    buffer
      ..write('message: $message')
      ..write(')');
    return buffer.toString();
  }
}
