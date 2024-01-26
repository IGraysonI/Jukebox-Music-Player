import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:jukebox_music_player/src/features/albums/widget/album_card_image.dart';
import 'package:jukebox_music_player/src/features/audio_query/scope/audio_query_scope.dart';

class AlbumsListView extends StatelessWidget {
  const AlbumsListView({
    required this.albums,
    required this.onTap,
    super.key,
  });

  final List<AlbumContent> albums;
  final void Function(AlbumInfo album) onTap;

  @override
  Widget build(BuildContext context) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => _AlbumListTile(
            album: albums[index].album,
            onTap: onTap,
          ),
          childCount: albums.length,
        ),
      );
}

class _AlbumListTile extends StatelessWidget {
  const _AlbumListTile({required this.album, required this.onTap});

  final AlbumInfo album;
  final void Function(AlbumInfo album) onTap;

  @override
  Widget build(BuildContext context) => ListTile(
        dense: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        leading: AspectRatio(
          aspectRatio: 1,
          child: Ink(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: AlbumCardImage(album),
          ),
        ),
        title: Text(
          album.title!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          album.artist!,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 16,
            height: 0.9,
            letterSpacing: -0.3,
            fontWeight: FontWeight.w400,
          ),
        ),
        onTap: () => onTap(album),
      );
}
