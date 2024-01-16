import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart' show BuildContext;
import 'package:jukebox_music_player/src/common/model/app_metadata.dart';
import 'package:jukebox_music_player/src/features/audio_query/controller/audio_query_controller.dart';
import 'package:jukebox_music_player/src/features/initialization/widget/scope/inherited_dependencies.dart';
import 'package:jukebox_music_player/src/features/settings/controller/settings_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Dependencies
class Dependencies {
  Dependencies();

  /// The state from the closest instance of this class.
  factory Dependencies.of(BuildContext context) => InheritedDependencies.of(context);

  /// App metadata
  late final AppMetadata appMetadata;

  /// Shared preferences
  late final SharedPreferences sharedPreferences;

  /// Firebase
  late final FirebaseApp firebaseApp;

  /// AudioQuery controller
  late final AudioQueryController audioQueryController;

  /// Settings controller
  late final SettingsController settingsController;
}
