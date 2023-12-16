import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import 'package:jukebox_music_player/src/common/widgets/basic/space.dart';
import 'package:jukebox_music_player/src/features/songs/widget/song_card.dart';

class SelectedAlbum extends StatelessWidget {
  const SelectedAlbum({
    required this.album,
    required this.songs,
    super.key,
  });

  final AlbumInfo album;
  final List<SongInfo> songs;

  @override
  Widget build(BuildContext context) => CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: album.albumArt == null
                ? null
                : MediaQuery.of(context).size.height * 0.55,
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => SongCard(
                song: songs[index],
                songIndex: index,
                album: album,
                showArtist: false,
                showArtwork: false,
              ),
              childCount: songs.length,
            ),
          ),
        ],
      );
}
