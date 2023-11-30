import 'package:logger/logger.dart';

class Log {
  static void info(dynamic message) {
    Logger().i(message);
  }

  static void error(dynamic message) {
    Logger().e(message);
  }

  static void debug(dynamic message) {
    Logger().d(message);
  }
}
