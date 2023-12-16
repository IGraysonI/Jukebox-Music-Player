import 'package:firebase_core/firebase_core.dart';

import 'package:jukebox_music_player/src/common/router/application_navigation.dart';
import 'package:jukebox_music_player/src/features/dependencies/model/app_metadata.dart';
import 'package:jukebox_music_player/src/features/settings/data/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class Dependencies {
  /// App metadata
  abstract final AppMetadata appMetadata;

  /// GoRouter navigator
  abstract final ApplicationNavigation navigation;

  /// Shared preferences
  abstract final SharedPreferences sharedPreferences;

  /// Firebase
  abstract final FirebaseApp firebaseApp;

  /// Settings Repository
  abstract final ISettingsRepository settingsRepository;
}
