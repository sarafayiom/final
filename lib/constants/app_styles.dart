import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppStyles {
  static const TextStyle headerLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle headerMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 14,
    color: AppColors.textPrimary,
  );

  static const TextStyle cardTitle = TextStyle(
    color: AppColors.textSecondary,
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  static const TextStyle cardDescription = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 14,
  );

  static ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.textSecondary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  );

  static BoxDecoration cardDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(20),
  );
} 