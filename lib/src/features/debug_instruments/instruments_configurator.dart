import 'package:l/l.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Map<Type, Object?> _di = {};

/// Конфигурируем инстременты на переданные инстансы
/// Все объекты, которые будут необходимы в debug instruments должны быть
/// переданы в этом конфигураторе
class InstrumentConfigurator {
  InstrumentConfigurator({SharedPreferences? sharedPreferences})
      : _sharedPreferences = sharedPreferences {
    _di.putIfAbsent(SharedPreferences, () => _sharedPreferences);
  }

  final SharedPreferences? _sharedPreferences;

  /// Получить из [_di] необходимый инстанс по типу [T]
  static T? get<T>() => _di[T] as T?;

  static void printDi() => _di.forEach((key, value) => l.i('$key: $value'));
}
