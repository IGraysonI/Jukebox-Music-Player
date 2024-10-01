import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class AlbumCardImage extends StatelessWidget {
  const AlbumCardImage(this.album, {super.key});

  final AlbumInfo album;

  @override
  Widget build(BuildContext context) => Material(
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
      );
}
