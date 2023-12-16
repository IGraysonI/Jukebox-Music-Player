import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:jukebox_music_player/src/features/settings/scope/setting_scope.dart';
import 'package:l/l.dart';

import 'package:jukebox_music_player/src/common/utils/logger_util.dart';
import 'package:jukebox_music_player/src/common/widgets/application.dart';
import 'package:jukebox_music_player/src/common/widgets/application_lifecycle_observer.dart';
import 'package:jukebox_music_player/src/features/dependencies/initialization/initialization.dart';
import 'package:jukebox_music_player/src/features/dependencies/scope/dependencies_scope.dart';
import 'package:jukebox_music_player/src/features/dependencies/widget/initialization_splash_screen.dart';

void main() => l.capture<void>(
      () => runZonedGuarded(
        () {
          final initialization = InitializationExecutor();
          runApp(
            ApplicationLifecycleObserver(
              child: DependenciesScope(
                initialization: initialization(),
                splashScreen:
                    InitializationSplashScreen(progress: initialization),
                child: const SettingsScope(
                  child: Application(),
                ),
              ),
            ),
          );
        },
        l.e,
      ),
      const LogOptions(
        handlePrint: true,
        messageFormatting: LoggerUtil.messageFormatting,
        outputInRelease: false,
        printColors: true,
      ),
    );
