import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class AlbumsPage extends StatefulWidget {
  const AlbumsPage({super.key});

  static String page() => 'AlbumsPage';

  @override
  State<AlbumsPage> createState() => _AlbumsPageState();
}

class _AlbumsPageState extends State<AlbumsPage> {
  @override
  Widget build(BuildContext context) => CustomScrollView(
        slivers: [
          const SliverAppBar(title: Text('Albums'), floating: true, snap: true),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: AlignedGridView.count(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                shrinkWrap: true,
                crossAxisCount: 2,
                itemBuilder: (context, index) => Text(index.toString()),
                // => AlbumCard(album: albums[index]),
              ),
            ),
          ),
        ],
      );
}
