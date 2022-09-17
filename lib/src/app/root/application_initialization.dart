import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../common/cache/shared_prefs_store.dart';
import '../../common/widgets/splash_screen.dart';
import '../../core/logger/l.dart';

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
  bool _applicationIsInitialized = false;

  void init() => _initApp()
      .then((value) => setState(() => _applicationIsInitialized = true));

  /// Инициализация компонентов приложения
  Future<void> _initApp() async {
    await ApplicationLogger().init();
    l.i('AppLogger инициализирован');

    await sharedPrefsStore.init();
    l.i('SharedPrefsStore инициализирован');
  }

  @override
  void initState() {
    // Первичная инициализация виджета
    init();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ApplicationInitialization oldWidget) {
    // Конфигурация виджета изменилась
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // Изменилась конфигурация InheritedWidget'ов
    // Так же вызывается после initState, но до build'а
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // Перманетное удаление стейта из дерева
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      _applicationIsInitialized ? widget.child : const SplashScreen();
}

/// Расширение на [BuildContext] для удобства получения сервисов
extension BundleX on BuildContext {
  /// Инстанс SharedPrefsStore
  SharedPrefsStore get cache =>
      ApplicationInitialization.of(this).sharedPrefsStore;

  /// Логгер
  Logger get logger => ApplicationInitialization.of(this).logger;
}
