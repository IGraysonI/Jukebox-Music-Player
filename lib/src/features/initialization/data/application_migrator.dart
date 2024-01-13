import 'dart:async';

import 'package:jukebox_music_player/src/common/constant/config.dart';
import 'package:jukebox_music_player/src/common/constant/pubspec.yaml.g.dart';
import 'package:l/l.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Migrate application when version is changed.
sealed class ApplicationMigrator {
  ApplicationMigrator._();

  static FutureOr<void> migrate(SharedPreferences sharedPreferences) async {
    try {
      final previousMajor = sharedPreferences.getInt(Config.versionMajorKey);
      final previousMinor = sharedPreferences.getInt(Config.versionMinorKey);
      final previousPatch = sharedPreferences.getInt(Config.versionPatchKey);
      if (previousMajor == null ||
          previousMinor == null ||
          previousPatch == null) {
        l.i('Initializing application for the first time');
      } else if (Pubspec.version.major != previousMajor ||
          Pubspec.version.minor != previousMinor ||
          Pubspec.version.patch != previousPatch) {
        l.i('Migrating from $previousMajor.$previousMinor.$previousPatch to ${Pubspec.version.major}.${Pubspec.version.minor}.${Pubspec.version.patch}');
      } else {
        l.i('Application is up to date');
        return;
      }
      await Future.wait<void>([
        sharedPreferences.setInt(Config.versionMajorKey, Pubspec.version.major),
        sharedPreferences.setInt(Config.versionMinorKey, Pubspec.version.minor),
        sharedPreferences.setInt(Config.versionPatchKey, Pubspec.version.patch),
      ]);
    } on Object catch (error, stackTrace) {
      l.e('Application migration failed: $error', stackTrace);
      return;
    }
  }
}
