import 'dart:io' as io;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

Future<void> $platformInitialization() =>
    io.Platform.isAndroid || io.Platform.isIOS ? _mobileInitialization() : _desktopInitialization();

//TODO:
Future<void> _mobileInitialization() async {}

Future<void> _desktopInitialization() async {
  await windowManager.ensureInitialized();
  final windowOptions = WindowOptions(
    minimumSize: const Size(360, 400),
    size: const Size(960, 800),
    maximumSize: const Size(1440, 1080),
    center: true,
    backgroundColor:
        //TODO: Add custom theme
        PlatformDispatcher.instance.platformBrightness == Brightness.dark
            ? ThemeData.dark().colorScheme.surface
            : ThemeData.light().colorScheme.surface,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    fullScreen: false,
    title: 'Jukebox Music Player',
  );
  await windowManager.waitUntilReadyToShow(
    windowOptions,
    () async {
      if (io.Platform.isMacOS) {
        await windowManager.setMovable(true);
      }
      await windowManager.setMaximizable(false);
      await windowManager.show();
      await windowManager.focus();
    },
  );
}
