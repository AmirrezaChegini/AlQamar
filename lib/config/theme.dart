import 'package:al_qamar/constants/colors.dart';
import 'package:al_qamar/widgets/slider_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    fontFamily: 'iranyekanmed',
    scaffoldBackgroundColor: AppColors.transparent,
    sliderTheme: SliderThemeData(
      trackShape: const GradientRectSliderTrackShape(),
      thumbColor: AppColors.blue,
      overlayColor: AppColors.blue.withOpacity(0.1),
      secondaryActiveTrackColor: AppColors.grey600,
      trackHeight: 3,
    ),
    textTheme: const TextTheme(
      //large
      titleLarge: TextStyle(
        fontWeight: FontWeight.w900,
        color: AppColors.grey,
      ),
      bodyLarge: TextStyle(
        fontWeight: FontWeight.w900,
        color: AppColors.black,
      ),
      labelLarge: TextStyle(
        fontWeight: FontWeight.w900,
        color: AppColors.white,
      ),
      displayLarge: TextStyle(
        fontWeight: FontWeight.w900,
        color: AppColors.blue,
      ),
      headlineLarge: TextStyle(
        fontWeight: FontWeight.w900,
        color: AppColors.red,
      ),
      //medium
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
      headlineMedium: TextStyle(
        fontWeight: FontWeight.w500,
        color: AppColors.red,
      ),
      //small
      titleSmall: TextStyle(
        fontWeight: FontWeight.w400,
        color: AppColors.grey,
      ),
      bodySmall: TextStyle(
        fontWeight: FontWeight.w400,
        color: AppColors.black,
      ),
      labelSmall: TextStyle(
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      displaySmall: TextStyle(
        fontWeight: FontWeight.w400,
        color: AppColors.blue,
      ),
      headlineSmall: TextStyle(
        fontWeight: FontWeight.w400,
        color: AppColors.red,
      ),
    ),
  );
}
