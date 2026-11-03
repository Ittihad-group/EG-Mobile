import 'environment.dart';

class AppConfig {
  const AppConfig({
    required this.environment,
    required this.apiBaseUrl,
    this.apiTimeoutSeconds = 30,
    this.appName = 'EG-Mobile ERP',
  });

  final Environment environment;
  final String apiBaseUrl;
  final int apiTimeoutSeconds;
  final String appName;

  static const development = AppConfig(
    environment: Environment.development,
    apiBaseUrl: 'https://api.example.com',
    apiTimeoutSeconds: 30,
  );

  static const staging = AppConfig(
    environment: Environment.staging,
    apiBaseUrl: 'https://staging-api.example.com',
  );

  static const production = AppConfig(
    environment: Environment.production,
    apiBaseUrl: 'https://api.egerman-upvc.com',
  );
}
