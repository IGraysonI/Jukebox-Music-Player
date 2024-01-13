import 'package:flutter/material.dart';

/// {@template application_error}
/// Application error widget.
/// {@endtemplate}
class ApplicationError extends StatelessWidget {
  /// {@macro application_error}
  const ApplicationError({
    this.error,
    super.key,
  });

  /// Error
  final Object? error;

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Application error',
        //TODO: add theme
        theme: View.of(context).platformDispatcher.platformBrightness ==
                Brightness.dark
            ? ThemeData.dark(useMaterial3: true)
            : ThemeData.light(useMaterial3: true),
        home: Scaffold(
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  error?.toString() ?? 'Something went wrong',
                  textScaler: TextScaler.noScaling,
                ),
              ),
            ),
          ),
        ),
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.noScaling,
          ),
          child: child!,
        ),
      );
}
