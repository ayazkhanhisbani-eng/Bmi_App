import 'package:flutter/material.dart';

/// Centralized color palette matching the UI reference exactly.
class AppColors {
  // Primary coral-orange gradient and accents
  static const Color coralPrimary = Color(0xFFFF6E4A);
  static const Color coralDark = Color(0xFFFF5238);
  static const Color coralLight = Color(0xFFFF8B66);
  static const Color coralSoft = Color(0xFFFFEAE3);
  static const Color coralBadgeBg = Color(0xFFFFF1EC);
  static const Color coralBorder = Color(0xFFFF7A59);

  // Background and surface
  static const Color scaffoldBg = Color(0xFFF8F9FA);
  static const Color cardBg = Colors.white;
  static const Color cardBorder = Color(0xFFF0F1F5);
  static const Color dividerColor = Color(0xFFEEEEEE);

  // Typography colors
  static const Color textDark = Color(0xFF1A1D26);
  static const Color textGray = Color(0xFF8E94A4);
  static const Color textLightGray = Color(0xFFB0B5C1);
  static const Color textCoral = Color(0xFFFF6E4A);

  // Stepper / Button accents
  static const Color stepperBtnBg = Colors.white;
  static const Color stepperBtnBorder = Color(0xFFE5E7EB);
  static const Color stepperIcon = Color(0xFF22252F);

  // Toggle buttons
  static const Color toggleInactiveBg = Color(0xFFF3F4F6);
  static const Color toggleInactiveText = Color(0xFF8E94A4);

  // BMI Gauge & Category Colors (matching WHO & design reference)
  static const Color underweight = Color(0xFF38B6FF); // Sky blue
  static const Color normal = Color(0xFF00C48C);      // Emerald green
  static const Color overweight = Color(0xFFFFCE38);  // Golden yellow
  static const Color obese1 = Color(0xFFFF8838);      // Orange
  static const Color obese2 = Color(0xFFFF4D4D);      // Red

  // Coral Gradient
  static const LinearGradient coralGradient = LinearGradient(
    colors: [
      Color(0xFFFF8B66),
      Color(0xFFFF5238),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Subtle button shadow
  static List<BoxShadow> get buttonShadow => [
    BoxShadow(
      color: coralDark.withValues(alpha: 0.35),
      blurRadius: 18,
      offset: const Offset(0, 8),
    ),
  ];

  // Soft card shadow
  static List<BoxShadow> get cardShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.04),
      blurRadius: 16,
      spreadRadius: 0,
      offset: const Offset(0, 4),
    ),
  ];
}
