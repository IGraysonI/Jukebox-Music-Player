import 'dart:async';

import 'package:l/l.dart';
import 'package:meta/meta.dart';
import 'package:platform_info/platform_info.dart';

import '../../../common/constant/config.dart';
import '../../../common/constant/pubspec.yaml.g.dart';
import '../../../common/controller/controller.dart';
import '../../../common/controller/controller_observer.dart';
import '../../../common/router/application_navigation.dart';
import '../../../common/utils/screen_util.dart';
import '../model/app_metadata.dart';
import '../model/dependencies.dart';

typedef _InitializationStep = FutureOr<void> Function(
  _MutableDependencies dependencies,
);

class _MutableDependencies implements Dependencies {
  @override
  late AppMetadata appMetadata;

  @override
  late ApplicationNavigation navigation;

  //TODO: repositories and blocs
  // late SomeRepository someRepository;
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

  List<(String, _InitializationStep)> get _initializationSteps =>
      <(String, _InitializationStep)>[
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
                  ? (int.tryParse(Pubspec.version.build.firstOrNull ?? '-1') ??
                      -1)
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
          (dependencies) =>
              dependencies.navigation = ApplicationNavigation.instance,
        ),
        (
          'Initialize analytics',
          //TODO: Initialize analytics
          (_) {}
        ),
        (
          'Log app open',
          //TODO: Log app open
          (_) {},
        ),
        //TODO: repositoryies and blocs
      ];
}
