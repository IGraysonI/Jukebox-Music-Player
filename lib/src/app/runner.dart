import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../core/bloc/application_bloc_observer.dart';
import '../core/logger/l.dart';
import 'root/application.dart';

/// Запуск приложения в своей зоне
Future<void> runner() async {
  await _initializeApplication();
  return runZonedGuarded(
    () {
      Bloc.observer = ApplicationBlocObserver();
      runApp(const Application());
    },
    (error, stackTrace) async => l.e('Critical Error: ', error, stackTrace),
  );
}

Future<void> _initializeApplication() async {
  /// The glue between the widgets layer and the Flutter engine.
  WidgetsFlutterBinding.ensureInitialized();
}
