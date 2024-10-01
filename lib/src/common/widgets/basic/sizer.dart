import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

/// {@template sizer}
/// Measure and call callback after child size changed.
/// {@endtemplate}
class Sizer extends SingleChildRenderObjectWidget {
  const Sizer({
    required super.child,
    this.onSizeChanged,
    this.dispatchNotification = false,
    super.key,
  });

  /// Callback when child size changed and after layout rebuild.
  final void Function(Size size)? onSizeChanged;

  /// Send [SizeChangedLayoutNotification] notification when child size changed.
  final bool dispatchNotification;

  @override
  RenderObject createRenderObject(BuildContext context) => _SizerRenderObject((size) {
        final fn = onSizeChanged;
        if (fn != null) {
          SchedulerBinding.instance.addPostFrameCallback((_) => fn(size));
        }
        if (dispatchNotification) {
          SizeChangedNotification(size).dispatch(context);
        }
      });
}

/// {@template sizer_render_object}
/// Render object for [Sizer].
/// {@endtemplate}
class _SizerRenderObject extends RenderProxyBox {
  /// {@macro sizer_render_object}
  _SizerRenderObject(this.onLayoutChangedCallback);

  /// Callback when child size changed and after layout rebuild.
  final void Function(Size size) onLayoutChangedCallback;

  Size? _oldSize;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) =>
      super.debugFillProperties(properties..add(DiagnosticsProperty('oldSize', size.toString())));

  @override
  void performLayout() {
    super.performLayout();
    final content = child;
    assert(content is RenderBox, 'Must contain context');
    assert(content?.hasSize ?? false, 'Content must obtain a size');
    final newSize = content?.size;
    if (newSize == null || newSize == _oldSize) return;
    _oldSize = newSize;
    onLayoutChangedCallback(newSize);
  }
}

/// {@template size_changed_layout_notification}
/// Notification about size changed.
/// {@endtemplate}
@immutable
class SizeChangedNotification extends SizeChangedLayoutNotification {
  /// {@macro size_changed_layout_notification}
  const SizeChangedNotification(this.size);

  /// current size of nested widget.
  final Size size;
}
