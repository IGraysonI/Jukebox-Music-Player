import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jukebox_music_player/src/features/albums/widget/album_card.dart';
import 'package:jukebox_music_player/src/features/audio_query/scope/audio_query_scope.dart';
import 'package:jukebox_music_player/src/features/controller/state_consumer.dart';
import 'package:jukevault/jukevault.dart';

class AlbumsWidget extends StatelessWidget {
  const AlbumsWidget({this.albums, super.key});

  final List<AlbumModel>? albums;

  @override
  Widget build(BuildContext context) => StateConsumer(
        controller: AudioQueryScope.controllerOf(context),
        builder: (context, state, _) => SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: AlignedGridView.count(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: albums?.length ?? state.albums.length,
              shrinkWrap: true,
              crossAxisCount: 2,
              itemBuilder: (context, index) => AlbumCard(
                album: albums?[index] ?? state.albums[index],
              ),
            ),
          ),
        ),
      );
}
