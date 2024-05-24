import 'package:flutter/material.dart';
import 'package:waveapp/theme/colors.dart';

class AppTheme {
  static final light = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: AppColors.lightColorScheme);
}
