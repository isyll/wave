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
    inputDecorationTheme: InputDecorationTheme(
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xff6f6f6f), width: 1)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: AppColors.lightColorScheme.secondary, width: 1)),
        labelStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color(0xff6f6f6f)),
        floatingLabelStyle:
            TextStyle(color: AppColors.lightColorScheme.secondary)),
  );
}
