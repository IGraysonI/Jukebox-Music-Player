import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../core/logger/l.dart';
import 'root/application.dart';

/// Запуск приложения в своей зоне
Future<void> runner() async {
  await _initializeApp();
  return runZonedGuarded(
    () => runApp(const Application()),
    (error, stack) async => l.e('Critical Error: ', error, stack),
  );
}

Future<void> _initializeApp() async {
  /// The glue between the widgets layer and the Flutter engine.
  WidgetsFlutterBinding.ensureInitialized();
}
