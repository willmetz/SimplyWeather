import 'package:logger/logger.dart';

class AppLogger {
  static final AppLogger _instance = AppLogger._internal();

  Logger _logger;

  factory AppLogger() {
    return _instance;
  }

  AppLogger._internal() {
    _logger = new Logger(filter: null, printer: PrettyPrinter(), output: null);
  }

  void d(String logMsg) {
    _logger.d(logMsg);
  }

  void w(String logMsg) {
    _logger.w(logMsg);
  }

  void e(String logMsg) {
    _logger.e(logMsg);
  }
}
