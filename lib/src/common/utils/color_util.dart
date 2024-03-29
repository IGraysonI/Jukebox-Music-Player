import 'package:flutter/material.dart';

sealed class ColorUtil {
  ColorUtil._();

  /// Get list of colors with length [count].
  static List<Color> getColors(int count) {
    final primariesLength = Colors.primaries.length;
    if (count <= primariesLength) return Colors.primaries.take(count).toList();

    final colors = List<Color>.filled(count, Colors.transparent);
    final step = count / (primariesLength - 1);

    var index = 0;
    for (var i = 0; i < primariesLength - 1; i++) {
      for (var j = 0; j < step; j++) {
        final color1 = Colors.primaries[i];
        final color2 = Colors.primaries[i + 1];
        colors[index] = Color.lerp(color1, color2, j / step)!;
        index++;
        if (index == count) return colors;
      }
    }

    while (index < count) {
      colors[index] = Colors.primaries.last;
      index++;
    }

    return colors;
  }
}
