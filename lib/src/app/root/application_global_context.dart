import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApplicationGlobalContext extends StatefulWidget {
  const ApplicationGlobalContext({required this.child, Key? key})
      : super(key: key);

  final Widget child;

  /// Для пойска _ApplicationGlobalContextState в контексте
  static _ApplicationGlobalContextState of(BuildContext context) =>
      context.findAncestorStateOfType<_ApplicationGlobalContextState>()!;

  @override
  State<ApplicationGlobalContext> createState() =>
      _ApplicationGlobalContextState();
}

class _ApplicationGlobalContextState extends State<ApplicationGlobalContext> {
  @override
  Widget build(BuildContext context) => _ProviderTree(child: widget.child);
}

/// Дерево провайдеров
class _ProviderTree extends StatelessWidget {
  const _ProviderTree({required this.child, Key? key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: const [],
      child: MultiBlocProvider(
        providers: const [],
        child: child,
      ),
    );
  }
}
