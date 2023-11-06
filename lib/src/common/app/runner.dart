import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../bloc/application_bloc_observer.dart';
import '../firebase/firebase_crashlytics_wrapper.dart';
import '../logger/l.dart';
import '../router/application_navigation.dart';
import '../utils/error_utils.dart';
import 'application.dart';

/// Запуск приложения в своей зоне
Future<void> runner() async {
  Bloc.observer = ApplicationBlocObserver();
  return runZonedGuarded(() async {
    await _initializeApplication();
    runApp(const Application());
  }, (error, stackTrace) async {
    if (kDebugMode) {
      l.e(
        'Critical Error: ',
        time: DateTime.now(),
        error: error,
        stackTrace: stackTrace,
      );
    } else {
      await FirebaseCrashlyticsWrapper.setCustomKey('ZONE_ERROR', true);
      await ErrorUtils.logError(error, stackTrace, isFatalError: true);
    }
  });
}

Future<void> _initializeApplication() async {
  /// The glue between the widgets layer and the Flutter engine.
  WidgetsFlutterBinding.ensureInitialized();

  /// Включает метод toString() для Equatable
  EquatableConfig.stringify = true;

  /// Инициализация навигации
  ApplicationNavigation.instance;
}
