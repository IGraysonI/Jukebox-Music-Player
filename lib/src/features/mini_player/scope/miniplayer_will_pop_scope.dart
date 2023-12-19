import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MiniplayerWillPopScope extends StatefulWidget {
  const MiniplayerWillPopScope({
    required this.child,
    required this.onWillPop,
    super.key,
  });

  final Widget child;
  final PopInvokedCallback onWillPop;

  @override
  MiniplayerWillPopScopeState createState() => MiniplayerWillPopScopeState();

  static MiniplayerWillPopScopeState? of(BuildContext context) =>
      context.findAncestorStateOfType<MiniplayerWillPopScopeState>();
}

class MiniplayerWillPopScopeState extends State<MiniplayerWillPopScope>
    implements PopEntry {
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
    _route?.unregisterPopEntry(this);
    super.dispose();
  }

  set descendant(MiniplayerWillPopScopeState? state) {
    _descendant = state;
    updateRouteCallback();
  }

  void updateRouteCallback() {
    _route?.unregisterPopEntry(this);
    _route = ModalRoute.of(context);
    _route?.registerPopEntry(this);
  }

  @override
  ValueListenable<bool> get canPopNotifier =>
      ValueNotifier(_route?.canPop ?? false);

  @override
  PopInvokedCallback? get onPopInvoked => widget.onWillPop;

  @override
  Widget build(BuildContext context) => widget.child;
}
