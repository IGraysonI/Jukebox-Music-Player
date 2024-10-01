class RegexValidator {
  const RegexValidator._();

  /// Выполнить проверку на полное соответсвие
  static bool validate(String source, String pattern) =>
      RegExp(pattern).hasMatch(source);

  /// Набор из цифр
  static bool integer(String source) => validate(source, r'[0-9]+$');

  /// Набор из букв (латиница)
  static bool latin(String source) => validate(source, r'[a-zA-Z]+$');

  /// Набор из букв (кириллица)
  static bool cyrillic(String source) => validate(source, r'[а-яА-ЯёЁ]+$');

  /// Набор из букв и цифр (латиница)
  static bool integerLatin(String source) => validate(source, r'[0-9a-zA-Z]+$');

  /// Набор из букв и цифр (кириллица)
  static bool integerCyrillic(String source) =>
      validate(source, r'[0-9а-яА-ЯёЁ]+$');

  /// Дата и время [DateTime]
  static bool date(String source) => DateTime.tryParse(source) is DateTime;

  /// Hex-Color
  /// (Формат #CCC или #CCCCCC)
  static bool color(String source) =>
      validate(source, r'^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$');
}
