import 'package:flutter/material.dart';

class FilledCard extends StatelessWidget {
  const FilledCard({
    required this.child,
    this.margin,
    this.padding,
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
          elevation: 0,
          color: Theme.of(context).colorScheme.surfaceVariant,
          margin: margin ?? EdgeInsets.zero,
          child: padding != null
              ? Padding(padding: padding!, child: child)
              : child,
        ),
      );
}
