import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_sizes.dart';

/// App-wide MaterialTheme configuration.
abstract final class AppTheme {
  /// The single theme used throughout the app.
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.accentOrange,
      surface: AppColors.background,
    ),
    fontFamily: 'RoundedFont',
    textTheme: const TextTheme(
      displayLarge:  AppTextStyles.storyTitle,
      headlineMedium: AppTextStyles.heading,
      bodyLarge:     AppTextStyles.body,
      labelLarge:    AppTextStyles.button,
      bodySmall:     AppTextStyles.small,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(AppSizes.buttonWidth, AppSizes.buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusButton),
        ),
        backgroundColor: AppColors.accentOrange,
        foregroundColor: AppColors.textLight,
        textStyle: AppTextStyles.button,
      ),
    ),
  );
}
