/// Расширение на [String]
extension StringX on String {
  String getDurationForSongLenght() {
    final doubleDuration = double.parse(this);
    final duration = Duration(milliseconds: doubleDuration.round());
    return '''${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}''';
  }
}
