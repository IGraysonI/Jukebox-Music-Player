import 'package:flutter/material.dart';
import 'package:shared_prefs_store/shared_prefs_store.dart';

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
  bool _appIsInited = false;

  late final SharedPrefsStore sharedPrefsStore = SharedPrefsStore();

  void init() =>
      _initApp().then((value) => setState(() => _appIsInited = true));

  /// Инициализация компонентов приложения
  Future<void> _initApp() async {
    await AppLogger().init();
    l
      ..i('AppLogger инициализирован')
      ..i('Приступаем к инициализации приложения');

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
      _appIsInited ? widget.child : const _SplashScreen();
}

// TODO: Переместить в отдельный файл
class _SplashScreen extends StatelessWidget {
  const _SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

extension BundleX on BuildContext {
  /// Инстанс SharedPrefsStore
  SharedPrefsStore get cache =>
      ApplicationInitialization.of(this).sharedPrefsStore;
}
