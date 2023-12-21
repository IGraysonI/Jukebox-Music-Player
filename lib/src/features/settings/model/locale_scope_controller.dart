import 'package:flutter/material.dart';

/// {@template locale_scope_controller}
/// A controller that holds and operates the app locale
/// {@endtemplate}
abstract interface class ILocaleScopeController {
  /// Get the current [Locale]
  Locale get locale;

  /// Set locale to [locale]
  void setLocale(Locale locale);
}
