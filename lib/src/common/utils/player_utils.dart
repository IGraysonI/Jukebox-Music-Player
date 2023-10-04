const double playerMinHeight = 70;
const double playerMaxHeight = 370;
const miniplayerPercentageDeclaration = 0.2;

double valueFromPercentageInRange({
  required final double min,
  required final double max,
  required final double percentage,
}) =>
    percentage * (max - min) + min;

double percentageFromValueInRange({
  required final double min,
  required final double max,
  required final double value,
}) =>
    (value - min) / (max - min);

double borderDouble({
  required double minRange,
  required double maxRange,
  required double value,
}) {
  if (value > maxRange) return maxRange;
  if (value < minRange) return minRange;
  return value;
}
