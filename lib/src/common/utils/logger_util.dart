import 'package:l/l.dart';

sealed class LoggerUtil {
  LoggerUtil._();

  /// Format the log message.
  static Object messageFormatting(
    Object message,
    LogLevel logLevel,
    DateTime now,
  ) =>
      '${timeFormat(now)} | $message';

  /// Format the time.
  static String timeFormat(DateTime time) =>
      '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
}
