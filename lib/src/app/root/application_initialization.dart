import 'package:firebase_core/firebase_core.dart';
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
  late final FirebaseApp firebaseApp;
  bool _applicationIsInitialized = false;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() => _initApp()
      .then((value) => setState(() => _applicationIsInitialized = true));

  /// Инициализация компонентов приложения
  Future<void> _initApp() async {
    // firebaseApp = await Firebase.initializeApp(options: Default);

    // await ApplicationLogger().init();
    l.i('ApplicationLogger инициализирован');

    await sharedPrefsStore.init();
    l.i('SharedPrefsStore инициализирован');
  }

  @override
  Widget build(BuildContext context) =>
      _applicationIsInitialized ? widget.child : const SplashScreen();
}
