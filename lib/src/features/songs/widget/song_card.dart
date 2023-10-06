import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:just_audio/just_audio.dart';

import '../../../common/extensions/string_extensions.dart';
import '../../music_player/scope/music_player_root_scope.dart';
import '../page/songs_page.dart';

class SongCard extends StatelessWidget {
  const SongCard({
    required this.songIndex,
    required this.song,
    this.showArtist = true,
    this.showArtwork = true,
    Key? key,
  }) : super(key: key);

  final int songIndex;
  final SongInfo song;
  final bool? showArtwork;
  final bool? showArtist;

  @override
  Widget build(BuildContext context) => ListTile(
        leading: showArtist!
            ? song.albumArtwork != null
                ? Image(image: FileImage(File(song.albumArtwork!)))
                : const Image(image: AssetImage('assets/images/no_image.jpg'))
            : Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(songIndex.toString())],
                ),
              ),
        title: Text(song.title!),
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
        onTap: () {
          final playlist = ConcatenatingAudioSource(
            useLazyPreparation: false,
            children: SongsPage.of(context)
                .songs
                .map((song) => AudioSource.file(song.filePath!, tag: song))
                .toList(),
          );

          MusicPlayerRootScope.playPlaylist(context, playlist, songIndex);
        },
        dense: false,
      );
}
