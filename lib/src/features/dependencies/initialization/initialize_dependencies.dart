import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:jukebox_music_player/firebase_options.dart';
import 'package:jukebox_music_player/src/common/constant/config.dart';
import 'package:jukebox_music_player/src/common/constant/pubspec.yaml.g.dart';
import 'package:jukebox_music_player/src/common/controller/controller.dart';
import 'package:jukebox_music_player/src/common/controller/controller_observer.dart';
import 'package:jukebox_music_player/src/common/firebase/firebase_crashlytics_wrapper.dart';
import 'package:jukebox_music_player/src/common/router/application_navigation.dart';
import 'package:jukebox_music_player/src/common/theme/theme_mode_codec.dart';
import 'package:jukebox_music_player/src/common/utils/screen_util.dart';
import 'package:jukebox_music_player/src/features/dependencies/model/app_metadata.dart';
import 'package:jukebox_music_player/src/features/dependencies/model/dependencies.dart';
import 'package:jukebox_music_player/src/features/settings/data/locale_data_source.dart';
import 'package:jukebox_music_player/src/features/settings/data/settings_repository.dart';
import 'package:jukebox_music_player/src/features/settings/data/theme_data_source.dart';
import 'package:l/l.dart';
import 'package:meta/meta.dart';
import 'package:platform_info/platform_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef _InitializationStep = FutureOr<void> Function(
  _MutableDependencies dependencies,
);

class _MutableDependencies implements Dependencies {
  @override
  late AppMetadata appMetadata;

  @override
  late ApplicationNavigation navigation;

  @override
  late SharedPreferences sharedPreferences;

  @override
  late FirebaseApp firebaseApp;

  @override
  late ISettingsRepository settingsRepository;
}

@internal
mixin InitializeDependencies {
  /// Инициализирует приложение и возвращает объект [Dependencies]
  @protected
  Future<Dependencies> $initializeDependencies({
    void Function(int progress, String message)? onProgress,
  }) async {
    final steps = _initializationSteps;
    final dependencies = _MutableDependencies();
    final totalSteps = steps.length;
    for (var currentStep = 0; currentStep < totalSteps; currentStep++) {
      final step = steps[currentStep];
      final percent = (currentStep * 100 ~/ totalSteps).clamp(0, 100);
      onProgress?.call(percent, step.$1);
      l.v6(
        'Initialization | $currentStep/$totalSteps ($percent%) | "${step.$1}"',
      );
      await step.$2(dependencies);
    }
    return dependencies;
  }

  List<(String, _InitializationStep)> get _initializationSteps => <(String, _InitializationStep)>[
        (
          'Creating app metadata',
          (dependencies) async {
            dependencies.appMetadata = AppMetadata(
              environment: Config.environment.value,
              isRelease: platform.buildMode.isRelease,
              appName: Pubspec.name,
              appVersion: Pubspec.version.canonical,
              appVersionMajor: Pubspec.version.major,
              appVersionMinor: Pubspec.version.minor,
              appVersionPatch: Pubspec.version.patch,
              appBuildTimestamp: Pubspec.version.build.isNotEmpty
                  ? (int.tryParse(Pubspec.version.build.firstOrNull ?? '-1') ?? -1)
                  : -1,
              operatingSystem: platform.operatingSystem.name,
              processorCount: platform.numberOfProcessors,
              locale: platform.locale,
              deviceVersion: platform.version,
              deviceLogicalScreenSize: ScreenUtil.screenSize().representation,
              appLaunchedTimestamp: DateTime.now(),
            );
          },
        ),
        (
          'Observer state managment',
          (_) => Controller.observer = ControllerObserver(),
        ),
        (
          'Initialize GoRouter navigator',
          (dependencies) => dependencies.navigation = ApplicationNavigation.instance,
        ),
        (
          'Initialize SharedPreferences',
          (dependencies) async => dependencies.sharedPreferences = await SharedPreferences.getInstance(),
        ),
        (
          'Firebase initialize app',
          (dependencies) async {
            dependencies.firebaseApp = await Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform,
            );
            await FirebaseCrashlyticsWrapper.setCustomKey(
              'kDebugMode',
              kDebugMode,
            );
          }
        ),
        (
          'Settings repository',
          (dependencies) {
            final sharedPreferences = dependencies.sharedPreferences;
            final themeDataSource = ThemeDataSourceImpl(
              sharedPreferences: sharedPreferences,
              codec: const ThemeModeCodec(),
            );
            final localeDataSource = LocaleDataSourceImpl(
              sharedPreferences: sharedPreferences,
            );
            dependencies.settingsRepository = SettingsRepositoryImpl(
              themeDataSource: themeDataSource,
              localeDataSource: localeDataSource,
            );
          }
        ),
        (
          'Fake delay 1',
          (_) => Future<void>.delayed(const Duration(milliseconds: 500)),
        ),
      ];
}
