import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../common/cache/shared_prefs_store.dart';
import '../../common/widgets/splash_screen.dart';
import '../../core/logger/l.dart';
import '../theme/theme_manager.dart';

/// Инициализация сервисов приложения
@immutable
class ApplicationInitialization extends StatefulWidget {
  const ApplicationInitialization({required this.child, Key? key})
      : super(key: key);

  final Widget child;

  static _ApplicationInitializationState of(BuildContext context) =>
      context.findAncestorStateOfType<_ApplicationInitializationState>()!;

  @override
  State<ApplicationInitialization> createState() =>
      _ApplicationInitializationState();
}

class _ApplicationInitializationState extends State<ApplicationInitialization> {
  late final SharedPrefsStore sharedPrefsStore = SharedPrefsStore();
  late final Logger logger = l;
  late final ThemeManager themeManager;
  bool _applicationIsInitialized = false;

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ApplicationInitialization oldWidget) =>
      super.didUpdateWidget(oldWidget);

  @override
  void didChangeDependencies() => super.didChangeDependencies();

  @override
  void dispose() => super.dispose();

  void init() => _initApp()
      .then((value) => setState(() => _applicationIsInitialized = true));

  /// Инициализация компонентов приложения
  Future<void> _initApp() async {
    await ApplicationLogger().init();
    l.i('ApplicationLogger инициализирован');

    await sharedPrefsStore.init();
    l.i('SharedPrefsStore инициализирован');
  }

  @override
  Widget build(BuildContext context) =>
      _applicationIsInitialized ? widget.child : const SplashScreen();
}
