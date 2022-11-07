import 'package:logger/logger.dart';

class LogUtils {
  static late Logger logger;

  static init() {
    logger = Logger();
  }

  static v(dynamic data) {
    logger.v(data);
  }

  static d(dynamic data) {
    logger.d(data);
  }

  static i(dynamic data) {
    logger.i(data);
  }

  static w(dynamic data) {
    logger.w(data);
  }

  static e(dynamic data) {
    logger.e(data);
  }

  static close() {
    logger.close();
  }

  LogUtils() {
    logger = Logger();
  }
}
