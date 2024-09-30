import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/common/extension/integer_extension.dart';
import 'package:jukebox_music_player/src/features/music_player/scope/music_player_scope.dart';
import 'package:jukevault/jukevault.dart';

class SongCard extends StatelessWidget {
  const SongCard({
    required this.songIndex,
    required this.song,
    this.album,
    this.showArtist = true,
    this.showArtwork = true,
    super.key,
  });

  final int songIndex;
  final AudioModel song;
  final AlbumModel? album;
  final bool? showArtwork;
  final bool? showArtist;

  @override
  Widget build(BuildContext context) => ListTile(
        leading: showArtist!
            ? QueryArtworkWidget(
                id: song.id,
                type: ArtworkType.AUDIO,
              )
            : Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(songIndex.toString())],
                ),
              ),
        title: Text(song.title),
        textColor: Colors.white,
        subtitle: Row(
          children: [
            if (showArtist!)
              Flexible(
                child: Text(
                  song.artist!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            if (showArtist!) const Text(' • '),
            Text(song.duration!.getDurationForSongLenght()),
          ],
        ),
        trailing: const Icon(Icons.more_vert_rounded, color: Colors.black),
        onTap: () => MusicPlayerScope.playPlaylist(
          context,
          MusicPlayerScope.createPlaylist(context, albumInfo: album),
          songIndex,
        ),
        dense: false,
      );
}
