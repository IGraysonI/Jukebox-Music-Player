import 'dart:io';

import 'package:logger/logger.dart';

///Реализация [LogOutput] для вывода логов в файл
class LoggerFileOutput extends LogOutput {
  LoggerFileOutput({required File file}) : _logFile = file;

  final File _logFile;
  late final IOSink _ioSink;

  @override
  void init() {
    _ioSink = _logFile.openWrite();
  }

  @override
  void destroy() {
    _ioSink.close();
  }

  @override
  Future<void> output(OutputEvent event) async {
    var isDebug = false;

    assert(
      () {
        return isDebug = true;
      }(),
      'LoggerFileOutput: output: event is null',
    );
    if (isDebug) {
      event.lines.forEach(print);
    }
    event.lines.forEach(_writeToFile);
  }

  void _writeToFile(Object object) {
    final log = object.toString();
    final formatted = log.substring(log.indexOf('  '), log.length);
    _ioSink.write(_addFileLogPrefix() + formatted + _addLogSuffix());
  }

  String _addLogSuffix() {
    const suffix = '\n';
    return suffix;
  }

  String _addFileLogPrefix() {
    final dt = DateTime.now();
    final day = dt.day.toString().padLeft(2, '0');
    final month = dt.month.toString().padLeft(2, '0');
    final hour = dt.hour.toString().padLeft(2, '0');
    final minute = dt.minute.toString().padLeft(2, '0');
    final second = dt.second.toString().padLeft(2, '0');
    final prefix = '$day/$month: $hour:$minute:$second - ';
    return prefix;
  }
}
