import 'dart:io';

import 'package:logger/logger.dart';

/// Реализация [LogOutput] для записи логов в файл
class LoggerFileOutput extends LogOutput {
  LoggerFileOutput({required File file}) : _logFile = file;

  late final IOSink _ioSink;
  final File _logFile;

  @override
  Future<void> init() {
    _ioSink = _logFile.openWrite();
    return super.init();
  }

  @override
  Future<void> destroy() {
    _ioSink.close();
    return super.destroy();
  }

  @override
  Future<void> output(OutputEvent event) async {
    var isDebug = false;
    assert(
      () {
        return isDebug = true;
      }(),
      'output assert message',
    );

    if (isDebug) {
      // ignore: avoid_print
      event.lines.forEach(print);
    }
    event.lines.forEach(_writeToFile);
  }

  void _writeToFile(Object object) {
    final log = object.toString();
    final formattedLog = log.substring(log.indexOf('  '), log.length);
    _ioSink.write(_addFileLogPrefix() + formattedLog + _addLogSuffix());
  }

  String _addFileLogPrefix() {
    final now = DateTime.now();
    final day = now.day.toString().padLeft(2, '0');
    final month = now.month.toString().padLeft(2, '0');
    final hour = now.hour.toString().padLeft(2, '0');
    final minute = now.minute.toString().padLeft(2, '0');
    final second = now.second.toString().padLeft(2, '0');
    final prefix = '$day/$month: $hour:$minute:$second -';
    return prefix;
  }

  String _addLogSuffix() => '\n';
}
