import 'dart:io';

import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart' as pp;

import 'logger_file_output.dart';

class ApplicationLogger {
  factory ApplicationLogger() => _instance;

  ApplicationLogger._internal();

  /// Singleton
  static final ApplicationLogger _instance = ApplicationLogger._internal();

  late Logger _logger;
  Logger get logger => _logger;

  Future<void> init() async {
    final directory = await pp.getApplicationDocumentsDirectory();
    final fileName = '${directory.path}/jukebox_log.txt';
    final isFileExist = File(fileName).existsSync();

    if (!isFileExist) {
      await File(fileName).create();
    }
    ApplicationLogger()._init(file: File(fileName));
  }

  void _init({File? file}) {
    if (file != null) {
      _logger = Logger(
        printer: SimplePrinter(),
        output: LoggerFileOutput(file: file),
        level: Level.verbose,
      );
    } else {
      _logger = Logger(
        printer: SimplePrinter(printTime: true),
        level: Level.verbose,
      );
    }
    _logger.i('Расположение логов: ${file?.path}');
  }
}

/// Шорткат логгера
Logger get l => ApplicationLogger()._logger;
