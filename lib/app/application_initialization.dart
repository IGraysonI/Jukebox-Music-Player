import 'package:flutter/material.dart';
import 'package:l/l.dart';

class ApplicationInitialization extends StatefulWidget {
  final Widget child;

  const ApplicationInitialization({Key? key, required this.child})
      : super(key: key);

  @override
  State<ApplicationInitialization> createState() =>
      _ApplicationInitializationState();
}

class _ApplicationInitializationState extends State<ApplicationInitialization> {
  @override
  Future<void> initState() async {
    l.i('Инициализируем приложение');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
