/// Разширение для [int]
extension IntegerExtension on int {
  /// Возвращает строку с длительностью песни
  String getDurationForSongLenght() {
    int seconds = this ~/ 1000;
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return "$minutes:${remainingSeconds.toString().padLeft(2, '0')}";
  }
}
