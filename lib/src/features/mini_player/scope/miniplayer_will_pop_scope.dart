import 'package:flutter/material.dart';

class MiniplayerWillPopScope extends StatefulWidget {
  const MiniplayerWillPopScope({
    required this.child,
    required this.onWillPop,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final WillPopCallback onWillPop;

  @override
  _MiniplayerWillPopScopeState createState() => _MiniplayerWillPopScopeState();

  static _MiniplayerWillPopScopeState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MiniplayerWillPopScopeState>();
}

class _MiniplayerWillPopScopeState extends State<MiniplayerWillPopScope> {
  ModalRoute<dynamic>? _route;

  _MiniplayerWillPopScopeState? _descendant;

  _MiniplayerWillPopScopeState? get descendant => _descendant;

  @override
  void didChangeDependencies() {
    final parentGuard = MiniplayerWillPopScope.of(context);
    if (parentGuard != null) {
      parentGuard.descendant = this;
    }
    updateRouteCallback();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _route?.removeScopedWillPopCallback(onWillPop);
    super.dispose();
  }

  set descendant(_MiniplayerWillPopScopeState? state) {
    _descendant = state;
    updateRouteCallback();
  }

  Future<bool> onWillPop() async {
    bool? willPop;

    if (_descendant != null) {
      willPop = await _descendant!.onWillPop();
    }

    if (willPop == null || willPop) {
      willPop = await widget.onWillPop();
    }

    return willPop;
  }

  void updateRouteCallback() {
    _route?.removeScopedWillPopCallback(onWillPop);
    _route = ModalRoute.of(context);
    _route?.addScopedWillPopCallback(onWillPop);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
