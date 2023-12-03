// ignore: avoid_classes_with_only_static_members
/// Config for the app
abstract final class Config {
  // --- API --- //

  /// Enviroment flavor
  /// e.g. development, staging, production
  static final EnvironmentFlavor environment = EnvironmentFlavor.from(
    const String.fromEnvironment('ENVIRONMENT', defaultValue: 'development'),
  );

  // --- Database --- //

  /// Whether to drop database on app start
  /// e.g. true, false
  static const bool dropDatabase =
      bool.fromEnvironment('DROP_DATABASE', defaultValue: false);

  /// Database file name by default
  /// e.g. sqlite means "sqlite" for native platforms and "db" for web
  static const String databaseFileName =
      String.fromEnvironment('DATABASE_FILE_NAME', defaultValue: 'sqlite');

  // --- Layout --- //

  /// Maximum screen layout width for screens with list view
  static const int maxScreenLayoutWidth = int.fromEnvironment(
    'MAX_SCREEN_LAYOUT_WIDTH',
    defaultValue: 768,
  );
}

/// Environment flavor
/// e.g. development, staging, production
enum EnvironmentFlavor {
  /// Development
  development('development'),

  /// Staging
  staging('staging'),

  /// Production
  production('production');

  /// {@nodoc}
  const EnvironmentFlavor(this.value);

  /// {@nodoc}
  factory EnvironmentFlavor.from(String? value) =>
      switch (value?.trim().toLowerCase()) {
        'development' || 'debug' || 'develop' || 'dev' => development,
        'staging' || 'profile' || 'stage' || 'stg' => staging,
        'production' || 'release' || 'prod' || 'prd' => production,
        _ => const bool.fromEnvironment('dart.vm.product')
            ? production
            : development,
      };

  /// development, staging, production
  final String value;

  /// Whether the environment is development
  bool get isDevelopment => this == development;

  /// Whether the environment is staging
  bool get isStaging => this == staging;

  /// Whether the environment is production
  bool get isProduction => this == production;
}
