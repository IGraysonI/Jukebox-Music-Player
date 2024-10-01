import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/common/widgets/button/common_actions.dart';

/// {@template not_found_screen}
/// NotFoundScreen widget.
/// {@endtemplate}
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({
    this.title,
    this.message,
    super.key,
  });

  final String? title;
  final String? message;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            title ?? 'Not found',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          actions: CommonActions(),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(48),
            child: SizedBox(height: 48),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Text(message ?? 'Content not found'),
          ),
        ),
      );
}
