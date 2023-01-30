import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';

import '../logger/l.dart';

/// Наблюдатель за всеми изменениями в блоках, выводит в консоль события,
/// ошибки, переход от ивента к состоянию, смены состояний
class ApplicationBlocObserver extends BlocObserver {
  final _spacer = ' ' * 5;

  @override
  void onCreate(BlocBase bloc) {
    final message = '[${bloc.runtimeType}Created]';
    _logI(message);
    super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase bloc) {
    final message = '[${bloc.runtimeType}Closed]';
    _logI(message);
    super.onClose(bloc);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    final message = '[${bloc.runtimeType}Event]$_spacer[$event]';
    _logI(message);
    super.onEvent(bloc, event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    final message = '[${bloc.runtimeType}Error] in [$bloc]';
    l.e(message, error, stackTrace);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    final message = '<${bloc.runtimeType}Transition>$_spacer<$transition>';
    _logI(message);
    super.onTransition(bloc, transition);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    final message = '<${bloc.runtimeType}Changed>$_spacer<$change>';
    _logI(message);
    super.onChange(bloc, change);
  }

  void _logI(
    String message, {
    bool shouldLog = true,
    Level level = Level.verbose,
  }) {
    if (!shouldLog) {
      return;
    } else {
      l.log(level, message);
    }
  }
}
