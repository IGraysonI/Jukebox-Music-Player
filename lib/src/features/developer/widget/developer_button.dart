import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/common/router/routes.dart';
import 'package:octopus/octopus.dart';

/// {@template developer_button}
/// DeveloperButton widget.
/// {@endtemplate}
class DeveloperButton extends StatelessWidget {
  /// {@macro developer_button}
  const DeveloperButton({super.key});

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: () => Octopus.of(context).push(Routes.developer),
        //TODO: add localization
        // tooltip: Localization.of(context).developer,
        icon: const Icon(Icons.developer_mode),
      );
}
