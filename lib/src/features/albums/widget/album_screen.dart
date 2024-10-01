import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:jukebox_music_player/src/common/extension/string_extensions.dart';
import 'package:jukebox_music_player/src/common/widgets/basic/not_found_screen.dart';
import 'package:jukebox_music_player/src/common/widgets/basic/scaffold_padding.dart';
import 'package:jukebox_music_player/src/common/widgets/button/common_actions.dart';
import 'package:jukebox_music_player/src/features/audio_query/scope/audio_query_scope.dart';
import 'package:jukebox_music_player/src/features/music_player/scope/music_player_scope.dart';

/// {@template album_screen}
/// AlbumScreen widget.
/// {@endtemplate}
class AlbumScreen extends StatelessWidget {
  /// {@macro album_screen}
  const AlbumScreen({
    required this.id,
    super.key,
  });

  final String? id;

  @override
  Widget build(BuildContext context) {
    if (id == null) return const NotFoundScreen();
    final albumContent = AudioQueryScope.getAlbumById(context, id!);
    if (albumContent == null) return const NotFoundScreen();
    final album = albumContent.album;
    final songs = albumContent.songs;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            title: Text(album.title ?? 'Album without title'),
            actions: CommonActions(),
          ),

          // --- Image and title --- //
          SliverPadding(
            padding: ScaffoldPadding.of(context).copyWith(bottom: 8),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Image --- //
                  SizedBox.square(
                    dimension: 200,
                    child: Material(
                      color: Colors.transparent,
                      child: Hero(
                        tag: 'album-${album.id}-image',
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(16),
                            image: album.albumArt == null
                                ? const DecorationImage(
                                    image: AssetImage('assets/images/no_image.jpg'),
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                  )
                                : DecorationImage(
                                    image: FileImage(File(album.albumArt!)),
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                  ),
                          ),
                          child: const SizedBox.expand(),
                        ),
                      ),
                    ),
                  ),

                  // --- Title --- //
                  Expanded(
                    child: SizedBox.square(
                      dimension: 200,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              album.title!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (album.artist != null)
                                        Text(
                                          'by ${album.artist!}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      Text('${album.numberOfSongs!} songs'),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.more_vert),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // TODO: ? add play and shuffle buttons
          SliverPadding(
            padding: ScaffoldPadding.of(context).copyWith(left: 8, right: 8),
            sliver: const SliverToBoxAdapter(
              child: Divider(),
            ),
          ),
          SliverPadding(
            padding: ScaffoldPadding.of(context).copyWith(left: 8, right: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _SongCardTile(
                  song: songs[index],
                  songIndex: index,
                  album: album,
                ),
                childCount: songs.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SongCardTile extends StatelessWidget {
  const _SongCardTile({
    required this.songIndex,
    required this.song,
    this.album,
  });

  final int songIndex;
  final SongInfo song;
  final AlbumInfo? album;

  @override
  Widget build(BuildContext context) => ListTile(
        leading: Text((songIndex + 1).toString()),
        title: Text(song.title!),
        subtitle: Row(
          children: [
            Flexible(
              child: Text(
                song.artist!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Text(' • '),
            Text(song.duration!.getDurationForSongLenght()),
          ],
        ),
        trailing: const Icon(Icons.more_vert_rounded, color: Colors.black),
        onTap: () => MusicPlayerScope.playPlaylist(
          context,
          MusicPlayerScope.createPlaylist(context, albumInfo: album),
          songIndex,
        ),
        dense: true,
      );
}
