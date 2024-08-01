import 'package:waveapp/utils/preference_utils.dart';

class AppInit {
  static void init() {
    PreferenceUtils.getString('transactions').isEmpty
        ? PreferenceUtils.setString('transactions', '[]')
        : null;
  }
}
