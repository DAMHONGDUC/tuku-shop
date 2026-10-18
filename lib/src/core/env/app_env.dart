// Names mirror the --dart-define keys they read.
// ignore_for_file: constant_identifier_names

class AppEnv {
  static const String APP_ENV = String.fromEnvironment(
    'APP_ENV',
    defaultValue: '',
  );

  static const String API_URL = String.fromEnvironment(
    'API_URL',
    defaultValue: '',
  );
}
