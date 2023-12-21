import 'package:jukebox_music_player/src/features/music_player/enum/panel_state_enum.dart';

/// {@template panel_state_extension}
/// An extension for the [PanelStateEnum] enum.
/// {@endtemplate}
extension SelectedColorExtension on PanelStateEnum {
  int get heightCode => switch (this) {
        PanelStateEnum.min => -1,
        PanelStateEnum.max => -2,
      };
}
