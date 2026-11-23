import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    final poppinsFamily = GoogleFonts.poppins().fontFamily;

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.scaffoldBg,
      primaryColor: AppColors.coralPrimary,
      fontFamily: poppinsFamily,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.coralPrimary,
        primary: AppColors.coralPrimary,
        surface: AppColors.scaffoldBg,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: AppColors.textDark,
          fontWeight: FontWeight.w700,
        ),
        headlineMedium: TextStyle(
          color: AppColors.textDark,
          fontWeight: FontWeight.w700,
        ),
        titleLarge: TextStyle(
          color: AppColors.textDark,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: TextStyle(
          color: AppColors.textDark,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: AppColors.textDark,
        ),
        bodyMedium: TextStyle(
          color: AppColors.textGray,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.textDark),
      ),
    );
  }
}
