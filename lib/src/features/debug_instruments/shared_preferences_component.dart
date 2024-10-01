import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/features/debug_instruments/instruments_configurator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsComponent extends StatefulWidget {
  const SharedPrefsComponent({super.key});

  @override
  State<SharedPrefsComponent> createState() => _SharedPrefsComponentState();
}

class _SharedPrefsComponentState extends State<SharedPrefsComponent> {
  final Map<String, Object?> _sharedPrefsMap = {};
  bool isPassed = false;

  @override
  void initState() {
    super.initState();
    _initialization();
  }

  void _initialization() {
    final instance = InstrumentConfigurator.get<SharedPreferences>();
    isPassed = instance != null;
    if (isPassed) _sharedPrefs(instance!);
  }

  void _sharedPrefs(SharedPreferences sharedPreferences) {
    final keys = sharedPreferences.getKeys();
    for (final key in keys) {
      _sharedPrefsMap.putIfAbsent(key, () => sharedPreferences.get(key));
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Shared Preferences')),
        body: ListView(
          children: [
            for (final key in _sharedPrefsMap.keys)
              ListTile(
                title: Text(key),
                subtitle: Text(_sharedPrefsMap[key].toString()),
              ),
          ],
        ),
      );
}
