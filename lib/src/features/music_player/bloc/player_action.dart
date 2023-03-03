/// Действия с плеером
enum PlayerAction {
  /// Начать воспроизведение
  play,

  /// Поставить на паузу
  pause,

  /// Перейти к следующему треку
  next,

  /// Перейти к предыдущему треку
  previous,

  /// Перейти к треку по индексу
  seekTo,

  /// Перемешать треки
  shuffle,

  /// Переключить режим повтора [off]
  repeatOff,

  /// Переключить режим повтора [all]
  repeatAll,

  /// Переключить режим повтора [one]
  repeatOne,
}
