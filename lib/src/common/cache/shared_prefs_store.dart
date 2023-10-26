import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'key_value_store.dart';
import 'type_store_key.dart';

///Singletor реализация [KeyValueStore] на основе [SharedPreferences]
class SharedPrefsStore implements KeyValueStore {
  factory SharedPrefsStore() => _singleton;

  SharedPrefsStore._();
  static final SharedPrefsStore _singleton = SharedPrefsStore._();

  bool _isInit = false;
  late SharedPreferences _sharedPreferences;

  SharedPreferences get sharedPreferences => _sharedPreferences;

  @override
  Future<void> init({SharedPreferences? sharedPreferences}) async {
    if (!_isInit) {
      _sharedPreferences =
          sharedPreferences ?? await SharedPreferences.getInstance();
      _isInit = true;
    }
  }

  @override
  T? read<T>(
    TypeStoreKey<T> typeStoreKey, {
    ValueStoreParser<T>? valueStoreParser,
  }) {
    final value = _sharedPreferences.get(typeStoreKey.key);
    if (value != null && value is String && value.startsWith('{')) {
      if (valueStoreParser == null) {
        throw Exception('In read<T> value != null'
            " && value is String && value.startsWith('{')"
            '\nbut valueStoreParser is null, '
            'u should pass method to parse non-primitive value from store');
      }
      return valueStoreParser(jsonDecode(value) as Map<String, Object?>);
    } else {
      return _sharedPreferences.get(typeStoreKey.key) as T?;
    }
  }

  @override
  Future<bool> contains(TypeStoreKey typeStoreKey) async =>
      _sharedPreferences.containsKey(typeStoreKey.key);

  @override
  Future<void> write<T>(TypeStoreKey<T> typeStoreKey, T? value) async {
    if (value == null) {
      await _sharedPreferences.remove(typeStoreKey.key);
      return;
    }
    switch (T) {
      case const (int):
        await _sharedPreferences.setInt(typeStoreKey.key, value as int);
        break;
      case const (String):
        await _sharedPreferences.setString(typeStoreKey.key, value as String);
        break;
      case const (double):
        await _sharedPreferences.setDouble(typeStoreKey.key, value as double);
        break;
      case const (bool):
        await _sharedPreferences.setBool(typeStoreKey.key, value as bool);
        break;
      case const (List):
        await _sharedPreferences.setStringList(
          typeStoreKey.key,
          value as List<String>,
        );
        break;
      default:
        await _sharedPreferences.setString(typeStoreKey.key, jsonEncode(value));
    }
  }
}
