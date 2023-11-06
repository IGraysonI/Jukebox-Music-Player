import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../app/application_initialization.dart';
import '../cache/shared_prefs_store.dart';

/// Расширение на [BuildContext] для удобства получения сервисов
extension BundleX on BuildContext {
  /// Инстанс SharedPrefsStore
  SharedPrefsStore get cache =>
      ApplicationInitialization.of(this).sharedPrefsStore;

  /// Логгер
  Logger get logger => ApplicationInitialization.of(this).logger;

  /// Firebase
  FirebaseApp get firebase => ApplicationInitialization.of(this).firebaseApp;
}
