import 'package:logger/logger.dart';

class ApplicationLogger {
  factory ApplicationLogger() => _instance;

  ApplicationLogger._internal();

  ///Singleton
  static final ApplicationLogger _instance = ApplicationLogger._internal();

  late Logger _logger;
  Logger get logger => _logger;

  Future<void> init() async {
    _logger = Logger(
      printer: SimplePrinter(),
      level: Level.verbose,
    );
  }
}

///Шорткат
Logger get l => ApplicationLogger()._logger;
