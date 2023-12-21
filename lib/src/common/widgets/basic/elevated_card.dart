import 'package:flutter/material.dart';

class ElevatedCard extends StatelessWidget {
  const ElevatedCard({
    required this.child,
    this.padding,
    this.margin,
    this.onCardTap,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onCardTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onCardTap,
        child: Card(
          margin: margin ?? EdgeInsets.zero,
          child: padding != null
              ? Padding(padding: padding!, child: child)
              : child,
        ),
      );
}
