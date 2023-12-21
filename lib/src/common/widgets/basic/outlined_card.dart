import 'package:flutter/material.dart';

class OutlinedCard extends StatelessWidget {
  const OutlinedCard({
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
          margin: margin,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).colorScheme.outline),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: padding != null
              ? Padding(padding: padding!, child: child)
              : child,
        ),
      );
}
