/// Разширение для [int]
extension IntegerExtension on int {
  /// Возвращает строку с длительностью песни
  String getDurationForSongLenght() {
    var seconds = this ~/ 1000;
    var minutes = seconds ~/ 60;
    var remainingSeconds = seconds % 60;
    return "$minutes:${remainingSeconds.toString().padLeft(2, '0')}";
  }
}
