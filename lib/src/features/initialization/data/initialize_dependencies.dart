import 'dart:async';

import 'package:control/control.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:jukebox_music_player/firebase_options.dart';
import 'package:jukebox_music_player/src/common/constant/pubspec.yaml.g.dart';
import 'package:jukebox_music_player/src/common/controller/controller_observer.dart';
import 'package:jukebox_music_player/src/common/firebase/firebase_crashlytics_wrapper.dart';
import 'package:jukebox_music_player/src/common/model/app_metadata.dart';
import 'package:jukebox_music_player/src/common/model/dependencies.dart';
import 'package:jukebox_music_player/src/common/theme/theme_mode_codec.dart';
import 'package:jukebox_music_player/src/common/util/screen_util.dart';
import 'package:jukebox_music_player/src/features/audio_query/controller/audio_query_controller.dart';
import 'package:jukebox_music_player/src/features/audio_query/data/audio_query_repository.dart';
import 'package:jukebox_music_player/src/features/initialization/data/application_migrator.dart';
import 'package:jukebox_music_player/src/features/initialization/data/platform/platform_initialization.dart';
import 'package:jukebox_music_player/src/features/settings/controller/settings_controller.dart';
import 'package:jukebox_music_player/src/features/settings/data/locale_data_source.dart';
import 'package:jukebox_music_player/src/features/settings/data/settings_repository.dart';
import 'package:jukebox_music_player/src/features/settings/data/theme_data_source.dart';
import 'package:l/l.dart';
import 'package:platform_info/platform_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Initializes the app and returns a [Dependencies] object.
Future<Dependencies> $initializeDependencies({
  void Function(int progress, String message)? onProgress,
}) async {
  final dependencies = Dependencies();
  final totalSteps = _initializationSteps.length;
  var currentStep = 0;
  for (final step in _initializationSteps.entries) {
    try {
      currentStep++;
      final percent = (currentStep * 100 ~/ totalSteps).clamp(0, 100);
      onProgress?.call(percent, step.key);
      l.v6('Initialization | $currentStep/$totalSteps ($percent%) | "${step.key}"');
      await step.value(dependencies);
    } on Object catch (error, stackTrace) {
      l.e('Initialization failed at step "${step.key}": $error', stackTrace);
      Error.throwWithStackTrace('Initialization failed at step "${step.key}": $error', stackTrace);
    }
  }
  return dependencies;
}

final Map<String, FutureOr<void> Function(Dependencies)> _initializationSteps = {
  'Platform pre-initialization': (_) => $platformInitialization(),
  'Creating app metadata': (dependencies) => dependencies.appMetadata = AppMetadata(
        isRelease: platform.buildMode.isRelease,
        appVersion: Pubspec.version.representation,
        appVersionMajor: Pubspec.version.major,
        appVersionMinor: Pubspec.version.minor,
        appVersionPatch: Pubspec.version.patch,
        appBuildTimestamp:
            Pubspec.version.build.isNotEmpty ? (int.tryParse(Pubspec.version.build.firstOrNull ?? '-1') ?? -1) : -1,
        appName: Pubspec.name,
        operatingSystem: platform.operatingSystem.name,
        processorsCount: platform.numberOfProcessors,
        locale: platform.locale,
        deviceVersion: platform.version,
        deviceScreenSize: ScreenUtil.screenSize().representation,
        appLaunchedTimestamp: DateTime.now(),
      ),
  'Observer state managment': (_) => Controller.observer = ControllerObserver(),
  'Initialize shared preferences': (dependencies) async =>
      dependencies.sharedPreferences = await SharedPreferences.getInstance(),
  'Migrate app from previous version': (dependencies) => ApplicationMigrator.migrate(dependencies.sharedPreferences),
  'Firebase initialize app': (dependencies) async {
    dependencies.firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseCrashlyticsWrapper.setCustomKey(
      'kDebugMode',
      kDebugMode,
    );
  },
  'AudioQuery controller': (dependencies) => dependencies.audioQueryController = AudioQueryController(
        audioQueryRepository: AudioQueryRepositoryImpl(),
      )..fetch(),
  'Settings controller': (dependencies) => dependencies.settingsController = SettingsController(
        settingsRepository: SettingsRepositoryImpl(
          themeDataSource: ThemeDataSourceImpl(
            sharedPreferences: dependencies.sharedPreferences,
            codec: const ThemeModeCodec(),
          ),
          localeDataSource: LocaleDataSourceImpl(
            sharedPreferences: dependencies.sharedPreferences,
          ),
        ),
      ),
};
