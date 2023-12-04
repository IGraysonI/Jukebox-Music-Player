import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../common/controller/state_consumer.dart';
import '../../audio_query/controller/audio_query_controller.dart';
import '../../audio_query/scope/audio_query_scope.dart';
import 'album_card.dart';

class AlbumsWidget extends StatefulWidget {
  const AlbumsWidget({this.albums, super.key});

  final List<AlbumInfo>? albums;

  @override
  State<AlbumsWidget> createState() => _AlbumsWidgetState();
}

class _AlbumsWidgetState extends State<AlbumsWidget> {
  late final AudioQueryController _audioQueryController;

  @override
  void initState() {
    super.initState();
    _audioQueryController = AudioQueryScope.controllerOf(context);
  }

  @override
  void dispose() {
    _audioQueryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => StateConsumer(
        controller: _audioQueryController,
        builder: (context, state, _) => SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
            child: AlignedGridView.count(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.albums?.length ?? state.albums.length,
              shrinkWrap: true,
              crossAxisCount: 2,
              itemBuilder: (context, index) => AlbumCard(
                album: widget.albums?[index] ?? state.albums[index],
              ),
            ),
          ),
        ),
      );
}
