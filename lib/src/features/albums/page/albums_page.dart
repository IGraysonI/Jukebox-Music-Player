import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/common/widgets/custom_sliver_app_bar.dart';

import 'package:jukebox_music_player/src/features/albums/widget/albums_widget.dart';

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({super.key});

  static String page() => 'AlbumsPage';

  @override
  State<AlbumsPage> createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  @override
  Widget build(BuildContext context) => const CustomScrollView(
        slivers: [
          CustomSliverAppBar(title: 'Albums'),
          AlbumsWidget(),
        ],
      );
}
