import 'package:firebase_crashlytics/firebase_crashlytics.dart';

/// Обертка для Firebase Crashlytics
abstract class FirebaseCrashlyticsWrapper {
  const FirebaseCrashlyticsWrapper._();

  static void crash() => FirebaseCrashlytics.instance.crash();

  static Future<void> recordError(
    Object error,
    StackTrace? stackTrace, {
    bool isFatalError = false,
  }) async =>
      FirebaseCrashlytics.instance.recordError(
        error,
        stackTrace,
        fatal: isFatalError,
      );

  static Future<void> log(String logMessage) async =>
      FirebaseCrashlytics.instance.log(logMessage);

  static Future<void> setCustomKey<T extends Object>(String key, T value) =>
      FirebaseCrashlytics.instance.setCustomKey(key, value);

  static Future<void> setUserId(String userId) =>
      FirebaseCrashlytics.instance.setUserIdentifier(userId);
}
