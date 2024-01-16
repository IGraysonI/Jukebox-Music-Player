import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jukebox_music_player/src/features/albums/widget/album_card.dart';
import 'package:jukebox_music_player/src/features/audio_query/scope/audio_query_scope.dart';

class AlbumsWidget extends StatelessWidget {
  const AlbumsWidget({this.albumContents, super.key});

  final List<AlbumContent>? albumContents;

  @override
  Widget build(BuildContext context) {
    List<AlbumContent> albums;
    if (albumContents == null)
      albums = AudioQueryScope.getAlbums(context);
    else
      albums = albumContents!;
    if (albums.isEmpty) return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
        child: AlignedGridView.count(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: albums.length,
          shrinkWrap: true,
          crossAxisCount: 2,
          itemBuilder: (context, index) => AlbumCard(
            album: albums[index].album,
            fromArtistScreen: albumContents != null,
          ),
        ),
      ),
    );
  }
}
