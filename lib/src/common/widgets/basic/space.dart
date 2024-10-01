import 'package:flutter/material.dart';

const double _space = 8;

class Space extends StatelessWidget {
  const Space._({required this.child});

  /// 4
  factory Space.xs() => const Space._(
        child: SizedBox(
          width: _space / 2,
          height: _space / 2,
        ),
      );

  /// 8
  factory Space.sm() => const Space._(
        child: SizedBox(
          width: _space,
          height: _space,
        ),
      );

  /// 16
  factory Space.md() => const Space._(
        child: SizedBox(
          width: _space * 2,
          height: _space * 2,
        ),
      );

  /// 24
  factory Space.lg() => const Space._(
        child: SizedBox(
          width: _space * 3,
          height: _space * 3,
        ),
      );

  /// 32
  factory Space.xl() => const Space._(
        child: SizedBox(
          width: _space * 4,
          height: _space * 4,
        ),
      );

  /// 64
  factory Space.xxl() => const Space._(
        child: SizedBox(
          width: _space * 8,
          height: _space * 8,
        ),
      );

  /// 96
  factory Space.xxxl() => const Space._(
        child: SizedBox(
          width: _space * 12,
          height: _space * 12,
        ),
      );

  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}
