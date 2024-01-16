import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/common/widgets/basic/custom_sliver_app_bar.dart';
import 'package:jukebox_music_player/src/features/albums/widget/albums_widget.dart';
import 'package:jukebox_music_player/src/features/jukebox_music_player/enum/navigation_tabs_enum.dart';
import 'package:octopus/octopus.dart';

/// {@template albums_tab}
/// AlbumsTab widget.
/// {@endtemplate}
class AlbumsTab extends StatelessWidget {
  /// {@macro albums_tab}
  const AlbumsTab({super.key});

  @override
  Widget build(BuildContext context) => BucketNavigator(
        bucket: '${NavigationTabsEnum.albums}-tab',
      );
}

/// {@template albums_screen}
/// AlbumsScreen widget.
/// {@endtemplate}
class AlbumsScreen extends StatefulWidget {
  /// {@macro albums_screen}
  const AlbumsScreen({super.key});

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  @override
  Widget build(BuildContext context) => const CustomScrollView(
        slivers: [
          CustomSliverAppBar(title: 'Albums'),
          AlbumsWidget(),
        ],
      );
}
