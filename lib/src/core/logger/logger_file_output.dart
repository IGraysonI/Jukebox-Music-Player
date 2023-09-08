import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import '../firebase/firebase_crashlytics_wrapper.dart';

/// Реализация [LogOutput] для записи логов
class LoggerOutput extends LogOutput {
  LoggerOutput();

  @override
  Future<void> output(OutputEvent event) async {
    if (kDebugMode) {
      // ignore: avoid_print
      event.lines.forEach(print);

      for (final log in event.lines) {
        await FirebaseCrashlyticsWrapper.log(log);
      }
    } else {
      for (final log in event.lines) {
        await FirebaseCrashlyticsWrapper.log(log);
      }
    }
  }
}
