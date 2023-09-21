import 'package:al_qamar/constants/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'iranyekanmed',
    scaffoldBackgroundColor: AppColors.transparent,
    textTheme: const TextTheme(
      labelLarge: TextStyle(
        fontWeight: FontWeight.w900,
        color: AppColors.white,
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColors.grey,
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
      labelMedium: TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      displayMedium: TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColors.blue,
      ),
    ),
  );
}
