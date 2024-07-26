import 'package:flutter/foundation.dart';

class AppConfig {
  static const maxHistoryItems = 10;
  static const appLostFocusTimeout = kDebugMode ? 10000 : 300;
  static const userInactivityTimeout = kDebugMode ? 10000 : 300;
}
