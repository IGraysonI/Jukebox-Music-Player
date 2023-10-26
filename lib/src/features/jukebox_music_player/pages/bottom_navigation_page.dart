import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({required this.child, super.key});

  final StatefulNavigationShell child;

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(child: widget.child),
        bottomNavigationBar: NavigationBar(
          selectedIndex: widget.child.currentIndex,
          onDestinationSelected: (index) => setState(
            () => widget.child.goBranch(
              index,
              initialLocation: index == widget.child.currentIndex,
            ),
          ),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.audiotrack_rounded),
              label: 'Songs',
            ),
            NavigationDestination(
              icon: Icon(Icons.album_rounded),
              label: 'Albums',
            ),
            NavigationDestination(
              icon: Icon(Icons.account_circle_rounded),
              label: 'Artists',
            ),
          ],
        ),
      );
}
