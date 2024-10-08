import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jukebox_music_player/src/common/widgets/basic/space.dart';
import 'package:window_manager/window_manager.dart';

/// {@template window_scope}
/// The window scope widget.
/// {@endtemplate}
class WindowScope extends StatefulWidget {
  /// {@macro window_scope}
  const WindowScope({
    required this.title,
    required this.child,
    super.key,
  });

  /// Title of the window.
  final String title;

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  State<WindowScope> createState() => _WindowScopeState();
}

class _WindowScopeState extends State<WindowScope> {
  @override
  Widget build(BuildContext context) => Platform.isAndroid || Platform.isIOS
      ? widget.child
      : Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _WindowTitle(),
            Expanded(child: widget.child),
          ],
        );
}

class _WindowTitle extends StatefulWidget {
  const _WindowTitle();

  @override
  State<_WindowTitle> createState() => __WindowTitleState();
}

class __WindowTitleState extends State<_WindowTitle> with WindowListener {
  final ValueNotifier<bool> _isFullScreen = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isAlwaysOnTop = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowEnterFullScreen() {
    super.onWindowEnterFullScreen();
    _isFullScreen.value = true;
  }

  @override
  void onWindowLeaveFullScreen() {
    super.onWindowLeaveFullScreen();
    _isFullScreen.value = false;
  }

  @override
  void onWindowFocus() {
    // Make sure to call once.
    setState(() {});
    //TODO: do something
  }

  void setAlwaysOnTop({required bool value}) => Future<void>(
        () async {
          await windowManager.setAlwaysOnTop(value);
          _isAlwaysOnTop.value = await windowManager.isAlwaysOnTop();
        },
      ).ignore();

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 24,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onPanStart: (details) => windowManager.startDragging(),
          onDoubleTap: null,
          child: Material(
            color: Theme.of(context).colorScheme.primary,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Builder(
                  builder: (context) {
                    final size = MediaQuery.of(context).size;
                    return AnimatedPositioned(
                      duration: const Duration(milliseconds: 350),
                      left: size.width < 800 ? 8 : 78,
                      right: 78,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          transitionBuilder: (child, animation) => FadeTransition(
                            opacity: animation,
                            child: ScaleTransition(
                              scale: animation,
                              child: child,
                            ),
                          ),
                          child: Text(
                            context.findAncestorWidgetOfExactType<WindowScope>()?.title ?? 'Jukebox Desktop',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(height: 1),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                _WindowButtons$Windows(
                  isFullScreen: _isFullScreen,
                  isAlwaysOnTop: _isAlwaysOnTop,
                  setAlwaysOnTop: (value) => setAlwaysOnTop(value: value),
                ),
              ],
            ),
          ),
        ),
      );
}

class _WindowButtons$Windows extends StatelessWidget {
  const _WindowButtons$Windows({
    required ValueListenable<bool> isFullScreen,
    required ValueListenable<bool> isAlwaysOnTop,
    required this.setAlwaysOnTop,
  })  : _isFullScreen = isFullScreen,
        _isAlwaysOnTop = isAlwaysOnTop;

  // ignore: unused_field
  final ValueListenable<bool> _isFullScreen;
  final ValueListenable<bool> _isAlwaysOnTop;
  final ValueChanged<bool> setAlwaysOnTop;

  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Is always on top
            ValueListenableBuilder(
              valueListenable: _isAlwaysOnTop,
              builder: (context, isAlwaysOnTop, _) => _WindowButton(
                onPressed: () => setAlwaysOnTop(!isAlwaysOnTop),
                icon: isAlwaysOnTop ? Icons.push_pin : Icons.push_pin_outlined,
              ),
            ),

            // Minimize
            _WindowButton(
              onPressed: windowManager.minimize,
              icon: Icons.minimize,
            ),

            //TODO: add isFullScreen

            // Close
            _WindowButton(
              onPressed: windowManager.close,
              icon: Icons.close,
            ),
            Space.sm(),
          ],
        ),
      );
}

class _WindowButton extends StatelessWidget {
  const _WindowButton({
    required this.onPressed,
    required this.icon,
  });

  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
          iconSize: 16,
          alignment: Alignment.center,
          padding: EdgeInsets.zero,
          splashRadius: 12,
          constraints: const BoxConstraints.tightFor(width: 24, height: 24),
        ),
      );
}
