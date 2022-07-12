import 'dart:io';

import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart' as pp;

import 'logger_file_output.dart';

class AppLogger {
  factory AppLogger() => _instance;

  AppLogger._internal();

  ///Singleton
  static final AppLogger _instance = AppLogger._internal();

  late Logger _logger;
  Logger get logger => _logger;

  Future<void> init() async {
    final dir = await pp.getApplicationDocumentsDirectory();
    final fileName = '${dir.path}/log.txt';
    final isExist = File(fileName).existsSync();

    if (!isExist) {
      await File(fileName).create();
    }

    AppLogger()._init(file: File(fileName));
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
    _logger.i('Расположение файла логов: ${file?.path}');
  }
}

///Шорткат
Logger get l => AppLogger()._logger;
