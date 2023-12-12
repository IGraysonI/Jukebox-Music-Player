import 'package:flutter/material.dart';

class MiniplayerWillPopScope extends StatefulWidget {
  const MiniplayerWillPopScope({
    required this.child,
    required this.onWillPop,
    super.key,
  });

  final Widget child;
  final WillPopCallback onWillPop;

  @override
  MiniplayerWillPopScopeState createState() => MiniplayerWillPopScopeState();

  static MiniplayerWillPopScopeState? of(BuildContext context) =>
      context.findAncestorStateOfType<MiniplayerWillPopScopeState>();
}

class MiniplayerWillPopScopeState extends State<MiniplayerWillPopScope> {
  ModalRoute<dynamic>? _route;

  MiniplayerWillPopScopeState? _descendant;

  MiniplayerWillPopScopeState? get descendant => _descendant;

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

  set descendant(MiniplayerWillPopScopeState? state) {
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
