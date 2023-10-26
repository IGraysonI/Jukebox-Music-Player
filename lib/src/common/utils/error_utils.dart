import 'package:meta/meta.dart';

import '../firebase/firebase_crashlytics_wrapper.dart';
import '../logger/l.dart';

@sealed
abstract class ErrorUtils {
  ErrorUtils._();

  static Future<void> logError(
    Object error,
    StackTrace stackTrace, {
    String? message,
    bool isFatalError = false,
  }) async {
    try {
      if (error is String) {
        return await logMessage(
          error,
          stackTrace: stackTrace,
          hint: message,
          isWarning: true,
        );
      }
    } on Object catch (error, stackTrace) {
      l.e(
        'Error while logging error inside ErrorUtils.logError()',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  static Future<void> logMessage(
    String message, {
    StackTrace? stackTrace,
    String? hint,
    List<String>? parameters,
    bool isWarning = false,
  }) async {
    try {
      await FirebaseCrashlyticsWrapper.log(
        '$message'
        '${stackTrace != null ? '\nStackTrace: $stackTrace' : ''}'
        '${hint != null ? '\nHint: $hint' : ''}'
        '${parameters != null ? '\nParameters: $parameters' : ''}'
        'isWarning: $isWarning',
      );
    } on Object catch (error, stackTrace) {
      l.e(
        'Error while logging message inside ErrorUtils.logMessage()',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  static Never throwWithStackTrace(Object error, StackTrace stackTrace) =>
      Error.throwWithStackTrace(error, stackTrace);

  // static String _textSplitter(Object source) {
  //   final length = source.toString().length;
  //   return source.toString().substring(0, length > 512 ? 512 : length);
  // }
}
