import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/common/widgets/basic/space.dart';
import 'package:jukebox_music_player/src/features/audio_query/scope/audio_query_scope.dart';

class SelectedAlbumScreen extends StatelessWidget {
  const SelectedAlbumScreen({required this.id, super.key});

  final String? id;

  @override
  Widget build(BuildContext context) {
    final albumContent = AudioQueryScope.getAlbumById(context, id!);
    if (albumContent == null) return const SizedBox.shrink();
    final album = albumContent.album;
    final songs = albumContent.songs;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: album.albumArt == null ? null : MediaQuery.of(context).size.height * 0.55,
          flexibleSpace: FlexibleSpaceBar(
            background: album.albumArt == null
                ? const SizedBox.shrink()
                : Image.file(
                    File(album.albumArt!),
                    height: MediaQuery.of(context).size.height * 0.55,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        SliverToBoxAdapter(child: Space.sm()),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  album.title!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Space.sm(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(album.artist!),
                        Text('${album.numberOfSongs!} songs'),
                      ],
                    ),
                    const Icon(Icons.more_vert),
                  ],
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(child: Space.sm()),
        //TODO: add widget to show album songs
        // SliverList(
        //   delegate: SliverChildBuilderDelegate(
        //     (context, index) => SongCard(
        //       song: songs[index],
        //       songIndex: index,
        //       album: album,
        //       showArtist: false,
        //       showArtwork: false,
        //     ),
        //     childCount: songs.length,
        //   ),
        // ),
      ],
    );
  }
}
