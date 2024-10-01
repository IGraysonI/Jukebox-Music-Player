import 'package:shared_preferences/shared_preferences.dart';

/// {@template preferences_dao}
/// Class that provides seamless access to the shared preferences.
///
/// Inspired by https://pub.dev/packages/typed_preferences
/// {@endtemplate}
abstract base class PreferencesDao {
  /// {@macro preferences_dao}
  const PreferencesDao({required SharedPreferences sharedPreferences})
      : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  /// Obtain [bool] entry from the shared preferences.
  PreferencesEntry<bool> boolEntry(String key) => _PreferencesEntry<bool>(
        sharedPreferences: _sharedPreferences,
        key: key,
      );

  /// Obtain [double] entry from the shared preferences.
  PreferencesEntry<double> doubleEntry(String key) => _PreferencesEntry<double>(
        sharedPreferences: _sharedPreferences,
        key: key,
      );

  /// Obtain [int] entry from the shared preferences.
  PreferencesEntry<int> intEntry(String key) => _PreferencesEntry<int>(
        sharedPreferences: _sharedPreferences,
        key: key,
      );

  /// Obtain [String] entry from the shared preferences.
  PreferencesEntry<String> stringEntry(String key) => _PreferencesEntry<String>(
        sharedPreferences: _sharedPreferences,
        key: key,
      );

  /// Obtain [Iterable<String>] entry from the shared preferences.
  PreferencesEntry<Iterable<String>> stringListEntry(String key) =>
      _PreferencesEntry<Iterable<String>>(
        sharedPreferences: _sharedPreferences,
        key: key,
      );
}

/// {@template preferences_entry}
/// [PreferencesEntry] describes a single entry in the shared preferences.
/// This is used to get and set values in the shared preferences.
/// {@endtemplate}
abstract base class PreferencesEntry<T extends Object> {
  /// {@macro preferences_entry}
  const PreferencesEntry();

  /// The key of the entry in the shared preferences.
  String get key;

  /// Obtain the value of the entry from the shared preferences.
  T? read();

  /// Set the value of the entry in the shared preferences.
  Future<void> set(T value);

  /// Remove the entry from the shared preferences.
  Future<void> remove();

  /// Set the value of the entry in the shared preferences
  /// if the value is not null.
  Future<void> setIfNullRemove(T? value) =>
      value != null ? set(value) : remove();
}

/// {@macro _preferences_entry}
final class _PreferencesEntry<T extends Object> extends PreferencesEntry<T> {
  /// {@macro _preferences_entry}
  _PreferencesEntry({
    required SharedPreferences sharedPreferences,
    required this.key,
  }) : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  @override
  final String key;

  @override
  T? read() {
    final value = _sharedPreferences.get(key);
    if (value == null) return null;
    if (value is T) return value;

    throw Exception(
        'The value of $key is not of type ${T.runtimeType.toString()}');
  }

  @override
  Future<void> set(T value) => switch (value) {
        final int value => _sharedPreferences.setInt(key, value),
        final double value => _sharedPreferences.setDouble(key, value),
        final String value => _sharedPreferences.setString(key, value),
        final bool value => _sharedPreferences.setBool(key, value),
        final Iterable<String> value =>
          _sharedPreferences.setStringList(key, value.toList()),
        _ => throw Exception(
            '$T is not a valid type for a shared preference entry'),
      };

  @override
  Future<void> remove() => _sharedPreferences.remove(key);
}
