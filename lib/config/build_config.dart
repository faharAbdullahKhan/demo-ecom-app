class BuildConfig {
  static const bool isProduction =
      bool.fromEnvironment('PRODUCTION', defaultValue: false);
  static const bool isInternal = !isProduction;

  static bool get enableChucker => isInternal;

  static String get envFileName {
    return 'lib/config/env/.env.dev';
  }

  static String get appTitle {
    if (isProduction) return 'Demo Ecommerce';
    return 'Demo Ecommerce (Internal)';
  }
}
