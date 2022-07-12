///Обьект типизированный ключ используемый
///в key-value хранилищах для более удобной работы с ними
///[T] - тип хранимого значения
///[key] - строковый ключ
///
///Хранилище может ограничивать типизацию [T],
///обычно оно ограничивается стандартными типами:
///[int], [double], [String], [bool]
class TypeStoreKey<T> {
  TypeStoreKey(this.key);

  final type = T;
  final String key;

  @override
  String toString() => 'TypeStoreKey(key: $key, valueType: $type)';
}
