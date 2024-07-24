import 'package:flutter/material.dart';
import 'package:waveapp/theme/colors.dart';
import 'package:waveapp/theme/text_theme.dart';

class AppTheme {
  static final light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: AppColors.lightColorScheme,
    fontFamily: 'Poppins',
    textTheme: AppTextTheme.light,
    scaffoldBackgroundColor: AppColors.lightColorScheme.surface,
  );
}
