import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:jukebox_music_player/src/common/widgets/button/history_button.dart';
import 'package:jukebox_music_player/src/features/developer/widget/developer_button.dart';

/// {@template common_actions}
/// Common actions widget with buttons.
/// {@endtemplate}
class CommonActions extends ListBase<Widget> {
  CommonActions([List<Widget>? actions])
      : _actions = <Widget>[
          ...?actions,
          const DeveloperButton(),
          const HistoryButton(),
        ];

  final List<Widget> _actions;

  @override
  int get length => _actions.length;

  @override
  set length(int newLength) => _actions.length = newLength;

  @override
  Widget operator [](int index) => _actions[index];

  @override
  void operator []=(int index, Widget value) => _actions[index] = value;
}
