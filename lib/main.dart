import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:l/l.dart';

import 'src/common/app/application_lifecycle_observer.dart';
import 'src/common/utils/logger_util.dart';
import 'src/common/widgets/application.dart';
import 'src/features/dependencies/initialization/initialization.dart';
import 'src/features/dependencies/scope/dependencies_scope.dart';
import 'src/features/dependencies/widget/initialization_splash_screen.dart';

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
                child: const Application(),
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
