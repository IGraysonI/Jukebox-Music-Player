import 'dart:async';

import 'package:l/l.dart';

/// Catch all application errors and logs.
void appZone(FutureOr<void> Function() fn) => l.capture(
      () => runZonedGuarded<void>(
        () => fn(),
        l.e,
      ),
      const LogOptions(
        handlePrint: true,
        messageFormatting: _messageFormatting,
        outputInRelease: false,
        printColors: true,
      ),
    );

/// Formats the log message.
Object _messageFormatting(
        Object message, LogLevel logLevel, DateTime dateTime) =>
    '${_timeFormat(dateTime)} | $message';

/// Format the time/
String _timeFormat(DateTime dateTime) =>
    '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';
