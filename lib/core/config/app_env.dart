import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract final class AppEnv {
  static const String _envFile = 'assets/env/.env';
  static const String _gnomesDataUrlKey = 'GNOMES_DATA_URL';

  static Future<void> load() async {
    try {
      await dotenv.load(fileName: _envFile);
    } catch (_) {
      // Recommended: Report exception to admin
    }
  }

  static String get gnomesDataUrl {
    return dotenv.get(_gnomesDataUrlKey);
  }
}
