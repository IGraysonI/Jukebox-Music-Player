import 'package:flutter/material.dart';

import '../widget/albums_widget.dart';

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
          SliverAppBar(title: Text('Albums'), floating: true, snap: true),
          AlbumsWidget(),
        ],
      );
}
