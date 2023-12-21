import 'dart:async';

import 'package:meta/meta.dart';

import 'package:jukebox_music_player/src/common/controller/controller.dart';

base mixin DroppableControllerConcurency on Controller {
  @override
  @nonVirtual
  bool get isProcessing => _$processingCalls > 0;
  int _$processingCalls = 0;

  @override
  @protected
  @mustCallSuper
  void handle(
    FutureOr<void> Function() handler, [
    FutureOr<void> Function(Object error, StackTrace stackTrace)? errorHandler,
    FutureOr<void> Function()? doneHandler,
  ]) =>
      runZonedGuarded<void>(
        () async {
          if (isDisposed || isProcessing) return;
          _$processingCalls++;

          try {
            await handler();
          } on Object catch (error, stackTrace) {
            onError(error, stackTrace);
            await Future<void>(
              () async => await errorHandler?.call(error, stackTrace),
            ).catchError(onError);
          } finally {
            await Future<void>(
              () async => await doneHandler?.call(),
            ).catchError(onError);
            _$processingCalls--;
          }
        },
        onError,
      );
}
