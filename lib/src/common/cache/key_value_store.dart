import 'type_store_key.dart';

/// Парсер для типа [T]
typedef ValueStoreParser<T> = T? Function(Map<String, Object?>);

/// Для типизированного хранилища данных вида ключ-значение
/// работающее с [TypeStoreKey]
abstract class KeyValueStore {
  /// Метод проверяющий, что по ключу [typedStoreKey]
  /// хранится какое-либо значение
  Future<bool> contains(TypeStoreKey typedStoreKey);

  /// Метод для инициализации хранилища
  Future<void> init();

  /// Метод для чтения значения по ключу [typedStoreKey], в случае если значение
  /// отсутствует возвращается null
  /// Если значение находится в хранилище, его тип приводится к [T]
  /// В случае если [T] не является примитивным типом,
  /// потребуется передать [valueStoreParser]
  T? read<T>(
    TypeStoreKey<T> typedStoreKey, {
    ValueStoreParser<T> valueStoreParser,
  });

  /// Метод для записи значения по ключу [typedStoreKey], при необходимости
  /// удалить значение необходимо передать null
  Future<void> write<T>(TypeStoreKey<T> typeStoreKey, T? value);
}
