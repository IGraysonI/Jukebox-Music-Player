import 'package:flutter/widgets.dart';
import 'package:jukebox_music_player/src/common/util/app_zone.dart';
import 'package:jukebox_music_player/src/common/util/error_util.dart';
import 'package:jukebox_music_player/src/common/widgets/application.dart';
import 'package:jukebox_music_player/src/common/widgets/application_error.dart';
import 'package:jukebox_music_player/src/common/widgets/application_lifecycle_observer.dart';
import 'package:jukebox_music_player/src/features/initialization/data/initialization.dart';
import 'package:jukebox_music_player/src/features/initialization/widget/scope/inherited_dependencies.dart';
import 'package:jukebox_music_player/src/features/settings/scope/setting_scope.dart';

void main() => appZone(
      () async {
        // Splash screen
        final initializationProgress = ValueNotifier<({int progress, String message})>(
          (progress: 0, message: ''),
        );
        $initializeApp(
          onProgress: (progress, message) => initializationProgress.value = (progress: progress, message: message),
          onSuccess: (dependencies) => runApp(
            //TODO: Move to other place
            ApplicationLifecycleObserver(
              child: InheritedDependencies(
                dependencies: dependencies,
                child: const SettingsScope(
                  child: Application(),
                ),
              ),
            ),
          ),
          onError: (error, stackTrace) {
            runApp(ApplicationError(error: error));
            ErrorUtil.logError(error, stackTrace).ignore();
          },
        ).ignore();
      },
    );
// l.capture<void>(
//       () => runZonedGuarded(
//         () {
//           final initialization = InitializationExecutor();
//           runApp(
//             ApplicationLifecycleObserver(
//               child: DependenciesScope(
//                 initialization: initialization(),
//                 splashScreen:
//                     InitializationSplashScreen(progress: initialization),
//                 child: const SettingsScope(
//                   child: Application(),
//                 ),
//               ),
//             ),
//           );
//         },
//         l.e,
//       ),
//       const LogOptions(
//         handlePrint: true,
//         messageFormatting: LoggerUtil.messageFormatting,
//         outputInRelease: false,
//         printColors: true,
//       ),
//     );
