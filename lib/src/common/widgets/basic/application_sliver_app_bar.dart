import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/common/router/routes.dart';
import 'package:jukebox_music_player/src/common/widgets/basic/space.dart';
import 'package:jukebox_music_player/src/common/widgets/button/common_actions.dart';
import 'package:octopus/octopus.dart';

class ApplicationSliverAppBar extends StatelessWidget {
  const ApplicationSliverAppBar({
    required this.title,
    this.flexibleSpace,
    this.expandedHeight,
    super.key,
  });

  /// The title of the app bar.
  final String title;

  /// The flexible space of the app bar.
  final Widget? flexibleSpace;

  /// The expanded height of the app bar.
  final double? expandedHeight;

  List<Widget> _menuChildren(BuildContext context) => [
        MenuItemButton(
          onPressed: () => context.octopus.push(Routes.settings),
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
        pinned: MediaQuery.sizeOf(context).height > 600,
        floating: true,
        snap: true,
        expandedHeight: expandedHeight,
        actions: [
          ...CommonActions(),
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
        flexibleSpace: flexibleSpace,
      );
}
