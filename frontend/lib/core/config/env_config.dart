import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000/api';
  static String get apiKey => dotenv.env['API_KEY'] ?? '';
  static String get env => dotenv.env['ENV'] ?? 'development';

  static bool get isProduction => env == 'production';
  static bool get isStaging => env == 'staging';
  static bool get isDevelopment => env == 'development';
}
