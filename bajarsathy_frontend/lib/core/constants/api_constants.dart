import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String get apiKey => dotenv.env['X_API_KEY'] ?? '';
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';
}

