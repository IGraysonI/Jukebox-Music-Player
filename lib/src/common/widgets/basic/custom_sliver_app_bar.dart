import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jukebox_music_player/src/features/debug_instruments/debug_instruments.dart';
import 'package:jukebox_music_player/src/features/debug_instruments/instruments_configurator.dart';
import 'package:jukebox_music_player/src/common/widgets/basic/space.dart';
import 'package:jukebox_music_player/src/features/dependencies/scope/dependencies_scope.dart';
import 'package:jukebox_music_player/src/features/settings/page/setting_page.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    required this.title,
    super.key,
  });

  /// The title of the app bar.
  final String title;

  List<Widget> _menuChildren(BuildContext context) => [
        MenuItemButton(
          onPressed: () => context.pushNamed(SettingPage.page()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.settings),
              Space.sm(),
              const Text('Настройки'),
            ],
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) => SliverAppBar(
        title: Text(title),
        floating: true,
        snap: true,
        actions: <Widget>[
          if (kDebugMode)
            DebugInstruments(
              instrumentConfigurator: InstrumentConfigurator(
                sharedPreferences:
                    DependenciesScope.of(context).sharedPreferences,
              ),
            ),
          MenuAnchor(
            builder: (context, controller, child) => IconButton(
              onPressed: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
              icon: const Icon(Icons.more_vert),
              tooltip: 'Показать меню',
            ),
            menuChildren: _menuChildren(context),
          ),
        ],
      );
}
