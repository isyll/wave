import 'package:flutter/material.dart';
import 'package:waveapp/theme/colors.dart';

class AppTextTheme {
  static final light = TextTheme(
      displayLarge: TextStyle(
          fontSize: 50,
          color: AppColors.lightColorScheme.onPrimary,
          fontWeight: FontWeight.bold),
      displayMedium: TextStyle(
          fontSize: 32,
          color: AppColors.lightColorScheme.onSurface,
          fontWeight: FontWeight.bold),
      displaySmall: TextStyle(
          fontSize: 18,
          color: AppColors.lightColorScheme.onSurface,
          fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(
          fontSize: 20,
          color: AppColors.lightColorScheme.onSecondary,
          fontWeight: FontWeight.normal));
}
