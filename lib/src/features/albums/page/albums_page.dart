import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../audio_query/bloc/audio_query_bloc.dart';
import '../../audio_query/scope/audio_query_root_scope.dart';
import '../widget/album_card.dart';

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
          BlocBuilder<AudioQueryBloc, AudioQueryState>(
            bloc: AudioQueryRooyScope.of(context).audioQueryBloc,
            builder: (context, state) => SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                child: AlignedGridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.albums.length,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  itemBuilder: (context, index) =>
                      AlbumCard(album: state.albums[index]),
                ),
              ),
            ),
          ),
        ],
      );
}
