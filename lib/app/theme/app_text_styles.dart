import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Text styles for the app. Min 24sp for child-facing text.
abstract final class AppTextStyles {
  static const String _fontFamily = 'RoundedFont';

  /// Large story title. 32sp.
  static const TextStyle storyTitle = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  /// Screen heading. 28sp.
  static const TextStyle heading = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textDark,
  );

  /// Body / instruction text. 24sp minimum.
  static const TextStyle body = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.normal,
    color: AppColors.textDark,
  );

  /// Button label. 24sp.
  static const TextStyle button = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textLight,
  );

  /// Small helper text (settings, parent section). 18sp — not child-facing.
  static const TextStyle small = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    color: AppColors.textDark,
  );
}
