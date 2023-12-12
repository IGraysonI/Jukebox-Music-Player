import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:l/l.dart';

import 'package:jukebox_music_player/src/common/firebase/firebase_crashlytics_wrapper.dart';
import 'package:jukebox_music_player/src/common/localization/localization.dart';

/// Error utility class.
sealed class ErrorUtil {
  ErrorUtil._();

  /// Logs the error to the console and to Firebase Crashlytics.
  static Future<void> logError(
    Object exception,
    StackTrace stackTrace, {
    String? hint,
    bool isFatalError = false,
  }) async {
    try {
      if (exception is String) {
        return await logMessage(
          exception,
          stackTrace: stackTrace,
          hint: hint,
          isWarning: true,
        );
      }
      $captureException(exception, stackTrace, hint, isFatalError: isFatalError)
          .ignore();
      l.e(exception, stackTrace);
    } on Object catch (error, stackTrace) {
      l.e(
        'Error while logging error "$error" inside ErrorUtil.logError',
        stackTrace,
      );
    }
  }

  /// Logs a message to the console and to Firebase Crashlytics.
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
      l.e(message, stackTrace ?? StackTrace.current);
      $captureMessage(message, stackTrace, hint, isWarning: isWarning).ignore();
    } on Object catch (error, stackTrace) {
      l.e(
        'Error while logging error "$error" inside ErrorUtil.logMessage',
        stackTrace,
      );
    }
  }

  static Never throwWithStackTrace(Object error, StackTrace stackTrace) =>
      Error.throwWithStackTrace(error, stackTrace);

  @pragma('vm:prefer-inline')
  static String _localizedError(
    String fallback,
    String Function(Localization l) localize,
  ) {
    try {
      return localize(Localization.current);
    } on Object {
      return fallback;
    }
  }

  /// Also we can add current localization to this method.
  static String formatMessage(
    Object error, [
    String fallback = 'An error has occurred',
  ]) =>
      switch (error) {
        final String e => e,
        FormatException _ =>
          _localizedError('Invalid format', (l) => l.errInvalidFormat),
        TimeoutException _ =>
          _localizedError('Timeout exceeded', (l) => l.errTimeOutExceeded),
        UnimplementedError _ =>
          _localizedError('Not implemented yet', (l) => l.errNotImplementedYet),
        UnsupportedError _ => _localizedError(
            'Unsupported operation',
            (l) => l.errUnsupportedOperation,
          ),
        FileSystemException _ =>
          _localizedError('File system error', (l) => l.errFileSystemException),
        AssertionError _ =>
          _localizedError('Assertion error', (l) => l.errAssertionError),
        Error _ => _localizedError(
            'An error has occurred',
            (l) => l.errAnErrorHasOccurred,
          ),
        Exception _ => _localizedError(
            'An exception has occurred',
            (l) => l.errAnExceptionHasOccurred,
          ),
        _ => fallback,
      };

  /// Shows an error snackbar with the given message.
  static void showSnackBar(BuildContext context, Object message) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(formatMessage(message)),
          backgroundColor: Colors.red,
        ),
      );
}

Future<void> $captureException(
  Object exception,
  StackTrace stackTrace,
  String? hint, {
  bool isFatalError = false,
}) =>
    Future<void>.value();

Future<void> $captureMessage(
  String message,
  StackTrace? stackTrace,
  String? hint, {
  bool isWarning = false,
}) =>
    Future<void>.value();
