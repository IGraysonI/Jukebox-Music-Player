import 'package:flutter/material.dart';

/// {@template outlined_text}
/// OutlinedText widget.
/// {@endtemplate}
class OutlinedText extends StatelessWidget {
  /// {@macro outlined_text}
  const OutlinedText(
    this.text, {
    this.style = const TextStyle(),
    this.maxLines = 1,
    this.strokeWidth = 4,
    this.fillColor,
    this.strokeColor,
    super.key,
  });

  final String text;
  final int maxLines;
  final TextStyle style;
  final double strokeWidth;
  final Color? fillColor;
  final Color? strokeColor;

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          // Stroked text as border.
          Text(
            text,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: style.copyWith(
              height: 0,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = strokeWidth
                ..color = strokeColor ?? Colors.black45,
            ),
          ),

          // Solid text as fill.
          Text(
            text,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: style.copyWith(
              height: 0,
              color: fillColor ?? Colors.grey.shade300,
            ),
          ),
        ],
      );
}
