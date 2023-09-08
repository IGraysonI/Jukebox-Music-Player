import 'package:logger/logger.dart';

import 'logger_file_output.dart';

class ApplicationLogger {
  factory ApplicationLogger() => _instance;

  ApplicationLogger._internal();

  /// Singleton
  static final ApplicationLogger _instance = ApplicationLogger._internal();

  late Logger _logger;

  Logger get logger => _logger;

  void init() => _logger = Logger(
        printer: SimplePrinter(),
        output: LoggerOutput(),
        level: Level.trace,
      );
}

/// Шорткат логгера
Logger get l => ApplicationLogger()._logger;
