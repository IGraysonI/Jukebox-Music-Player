import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

/// {@macro screen_util}
extension ScreenUtilExtenstion on BuildContext {
  /// Get current screen logical size representation
  ///
  /// phone   | <= 600 dp      | 4 column
  /// tablet  | 600..10023 dp  | 8 column
  /// desktop | >= 1024 dp     | 12 column
  ScreenSize get screenSize => ScreenUtil.screenSizeOf(this);

  /// Portrait or landscape orientation
  Orientation get orientation => ScreenUtil.orientationOf(this);

  /// Evalute the result of the first matching callback
  ///
  /// phone  | <= 600 dp      | 4 column
  /// tablet | 600..10023 dp  | 8 column
  /// desktop| >= 1024 dp     | 12 column
  ScreenSizeWhenResult screenSizeWhen<ScreenSizeWhenResult extends Object?>({
    required ScreenSizeWhenResult Function() phone,
    required ScreenSizeWhenResult Function() tablet,
    required ScreenSizeWhenResult Function() desktop,
  }) =>
      ScreenUtil.screenSizeOf(this).when(
        phone: phone,
        tablet: tablet,
        desktop: desktop,
      );

  /// The [screenSizeMaybeWhen] method is equivalent to [screenSizeWhen],
  /// but doesn't require all callbacks to be specified.
  ///
  /// On the other hand, it adds an extra [orElse] required parameter,
  /// for fallback behavior.
  ScreenSizeWhenResult
      screenSizeMaybeWhen<ScreenSizeWhenResult extends Object?>({
    required final ScreenSizeWhenResult Function() orElse,
    final ScreenSizeWhenResult Function()? phone,
    final ScreenSizeWhenResult Function()? tablet,
    final ScreenSizeWhenResult Function()? desktop,
  }) =>
          ScreenUtil.screenSizeOf(this).maybeWhen(
            phone: phone,
            tablet: tablet,
            desktop: desktop,
            orElse: orElse,
          );
}

// ignore: avoid_classes_with_only_static_members
/// Screen logical size representation
///
/// phone   | <= 600 dp      | 4 column
/// tablet  | 600..10023 dp  | 8 column
/// desktop | >= 1024 dp     | 12 column
sealed class ScreenUtil {
  /// {@macro screen_util}
  static ScreenSize screenSize() {
    final view = ui.PlatformDispatcher.instance.implicitView;
    if (view == null) return ScreenSize.phone;
    final size = view.physicalSize ~/ view.devicePixelRatio;
    return _screenSizeFromSize(size);
  }

  static ScreenSize from(Size size) => _screenSizeFromSize(size);

  /// {@macro screen_util}
  static ScreenSize screenSizeOf(final BuildContext context) {
    final size = MediaQuery.of(context).size;
    return _screenSizeFromSize(size);
  }

  static ScreenSize _screenSizeFromSize(final Size size) =>
      switch (size.width) {
        >= 1024 => ScreenSize.desktop,
        <= 600 => ScreenSize.phone,
        _ => ScreenSize.tablet,
      };

  /// Portrait or landscape orientation
  static Orientation orientation() {
    final view = ui.PlatformDispatcher.instance.implicitView;
    final size = view?.physicalSize;
    return size == null || size.height > size.width
        ? Orientation.portrait
        : Orientation.landscape;
  }

  /// Portrait or landscape orientation
  static Orientation orientationOf(BuildContext context) =>
      MediaQuery.of(context).orientation;
}

/// {@macro screen_util}
@immutable
sealed class ScreenSize {
  /// {@macro screen_util}
  @literal
  const ScreenSize._(this.representation, this.min, this.max);

  /// Phone
  static const ScreenSize phone = ScreenSize$Phone();

  /// Tablet
  static const ScreenSize tablet = ScreenSize$Tablet();

  /// Large desktop
  static const ScreenSize desktop = ScreenSize$Desktop();

  /// Minimum width in logical pixels
  final double min;

  /// Maximum width in logical pixels
  final double max;

  /// String representation
  final String representation;

  /// Is phone
  abstract final bool isPhone;

  /// Is tablet
  abstract final bool isTablet;

  /// Is desktop
  abstract final bool isDesktop;

  /// Evaluate the result of the first matching callback
  ///
  /// phone  | <= 600 dp      | 4 column
  /// tablet | 600..10023 dp  | 8 column
  /// desktop| >= 1024 dp     | 12 column
  ScreenSizeWhenResult when<ScreenSizeWhenResult extends Object?>({
    required ScreenSizeWhenResult Function() phone,
    required ScreenSizeWhenResult Function() tablet,
    required ScreenSizeWhenResult Function() desktop,
  });

  /// The [maybeWhen] method is equivalent to [when], but doesn't require all
  /// callbacks to be specified
  ///
  /// On the other hand, its adds an extra [orElse] required parameter, for
  /// fallback behavior
  ScreenSizeWhenResult maybeWhen<ScreenSizeWhenResult extends Object?>({
    required ScreenSizeWhenResult Function() orElse,
    ScreenSizeWhenResult Function()? phone,
    ScreenSizeWhenResult Function()? tablet,
    ScreenSizeWhenResult Function()? desktop,
  }) =>
      when<ScreenSizeWhenResult>(
        phone: phone ?? orElse,
        tablet: tablet ?? orElse,
        desktop: desktop ?? orElse,
      );

  @override
  String toString() => representation;
}

/// {@macro screen_util}
final class ScreenSize$Phone extends ScreenSize {
  /// {@macro screen_util}
  @literal
  const ScreenSize$Phone() : super._('Phone', 0, 599);

  @override
  ScreenSizeWhenResult when<ScreenSizeWhenResult extends Object?>({
    required ScreenSizeWhenResult Function() phone,
    required ScreenSizeWhenResult Function() tablet,
    required ScreenSizeWhenResult Function() desktop,
  }) =>
      phone();

  @override
  bool get isPhone => true;

  @override
  bool get isTablet => false;

  @override
  bool get isDesktop => false;

  @override
  int get hashCode => 0;

  @override
  bool operator ==(final Object other) =>
      identical(other, this) || other is ScreenSize$Phone;
}

/// {@macro screen_util}
final class ScreenSize$Tablet extends ScreenSize {
  /// {@macro screen_util}
  @literal
  const ScreenSize$Tablet() : super._('Tablet', 600, 1023);

  @override
  ScreenSizeWhenResult when<ScreenSizeWhenResult extends Object?>({
    required ScreenSizeWhenResult Function() phone,
    required ScreenSizeWhenResult Function() tablet,
    required ScreenSizeWhenResult Function() desktop,
  }) =>
      tablet();

  @override
  bool get isPhone => false;

  @override
  bool get isTablet => true;

  @override
  bool get isDesktop => false;

  @override
  int get hashCode => 1;

  @override
  bool operator ==(final Object other) =>
      identical(other, this) || other is ScreenSize$Tablet;
}

/// {@macro screen_util}
final class ScreenSize$Desktop extends ScreenSize {
  /// {@macro screen_util}
  @literal
  const ScreenSize$Desktop() : super._('Desktop', 1024, double.infinity);

  @override
  ScreenSizeWhenResult when<ScreenSizeWhenResult extends Object?>({
    required ScreenSizeWhenResult Function() phone,
    required ScreenSizeWhenResult Function() tablet,
    required ScreenSizeWhenResult Function() desktop,
  }) =>
      desktop();

  @override
  bool get isPhone => false;

  @override
  bool get isTablet => false;

  @override
  bool get isDesktop => true;

  @override
  int get hashCode => 2;

  @override
  bool operator ==(final Object other) =>
      identical(other, this) || other is ScreenSize$Desktop;
}
