import 'package:firebase_core/firebase_core.dart';

import 'package:jukebox_music_player/src/common/cache/shared_prefs_store.dart';
import 'package:jukebox_music_player/src/common/router/application_navigation.dart';
import 'package:jukebox_music_player/src/features/dependencies/model/app_metadata.dart';

abstract interface class Dependencies {
  /// App metadata
  abstract final AppMetadata appMetadata;

  /// GoRouter navigator
  abstract final ApplicationNavigation navigation;

  /// SharedPrefsStore
  abstract final SharedPrefsStore sharedPrefsStore;

  /// Firebase
  abstract final FirebaseApp firebaseApp;
}
