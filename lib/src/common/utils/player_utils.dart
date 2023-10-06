import 'package:flutter/material.dart';

final ValueNotifier<double> playerExpandProgress =
    ValueNotifier(_playerMinHeight);

const double _playerMinHeight = 70;
// const double playerMaxHeight = 370;
const _miniplayerPercentageDeclaration = 0.2;

class PlayerUtils {
  PlayerUtils._();

  static double get playerMinHeight => _playerMinHeight;

  static double get miniplayerPercentageDeclaration =>
      _miniplayerPercentageDeclaration;

  static double valueFromPercentageInRange({
    required final double min,
    required final double max,
    required final double percentage,
  }) =>
      percentage * (max - min) + min;

  static double percentageFromValueInRange({
    required final double min,
    required final double max,
    required final double value,
  }) =>
      (value - min) / (max - min);

  static double borderDouble({
    required double minRange,
    required double maxRange,
    required double value,
  }) {
    if (value > maxRange) return maxRange;
    if (value < minRange) return minRange;
    return value;
  }
}
