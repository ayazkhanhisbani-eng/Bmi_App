import 'package:flutter/material.dart';
import '../ui/theme/app_colors.dart';

enum BmiCategory {
  underweight,
  normal,
  overweight,
  obeseClass1,
  obeseClass2;

  String get label {
    switch (this) {
      case BmiCategory.underweight:
        return 'Underweight';
      case BmiCategory.normal:
        return 'Normal';
      case BmiCategory.overweight:
        return 'Overweight';
      case BmiCategory.obeseClass1:
        return 'Obese class I';
      case BmiCategory.obeseClass2:
        return 'Obese class II';
    }
  }

  Color get color {
    switch (this) {
      case BmiCategory.underweight:
        return AppColors.underweight;
      case BmiCategory.normal:
        return AppColors.normal;
      case BmiCategory.overweight:
        return AppColors.overweight;
      case BmiCategory.obeseClass1:
        return AppColors.obese1;
      case BmiCategory.obeseClass2:
        return AppColors.obese2;
    }
  }

  /// Range string for display
  String get rangeString {
    switch (this) {
      case BmiCategory.underweight:
        return '< 18.5';
      case BmiCategory.normal:
        return '18.5 - 24.9';
      case BmiCategory.overweight:
        return '25.0 - 29.9';
      case BmiCategory.obeseClass1:
        return '30.0 - 34.9';
      case BmiCategory.obeseClass2:
        return '≥ 35.0';
    }
  }

  /// Tailored, evidence-based recommendations
  List<String> get recommendations {
    switch (this) {
      case BmiCategory.underweight:
        return [
          'Incorporate nutrient-dense foods rich in healthy fats, protein, and complex carbohydrates.',
          'Consider strength training exercises to build lean muscle mass rather than just body fat.',
          'Eat smaller, frequent meals throughout the day and include healthy caloric snacks like nuts and seeds.',
          'Consult a healthcare provider or registered dietitian to identify underlying nutritional needs.',
        ];
      case BmiCategory.normal:
        return [
          'Maintain your balanced diet featuring whole grains, fresh vegetables, lean proteins, and fruits.',
          'Engage in at least 150 minutes of moderate aerobic activity or 75 minutes of vigorous activity weekly.',
          'Stay consistently hydrated with 2-3 liters of water daily and prioritize 7-9 hours of quality sleep.',
          'Keep tracking your body metrics periodically to sustain long-term metabolic health.',
        ];
      case BmiCategory.overweight:
        return [
          'Aim for a gradual, sustainable caloric deficit through mindful portion management.',
          'Combine daily brisk walking or cardiovascular exercise with resistance training.',
          'Reduce intake of ultra-processed snacks, sugary drinks, and refined carbohydrates.',
          'Prioritize high-fiber foods and proteins to stay satiated and maintain steady energy levels.',
        ];
      case BmiCategory.obeseClass1:
        return [
          'Adopt a structured nutritional plan developed alongside a licensed health professional.',
          'Focus on low-impact cardiovascular exercises such as swimming, cycling, or brisk walking to protect joints.',
          'Monitor blood pressure, cholesterol, and blood glucose markers regularly.',
          'Prioritize behavioral changes such as mindful eating, stress management, and restorative sleep.',
        ];
      case BmiCategory.obeseClass2:
        return [
          'Schedule a comprehensive health consultation with your physician for personalized medical guidance.',
          'Begin with gentle, medically supervised physical activity to steadily enhance mobility and stamina.',
          'Focus on whole foods, eliminate sugary beverages, and track daily caloric balance consistently.',
          'Seek support from a multidisciplinary team including a nutritionist and lifestyle counselor.',
        ];
    }
  }

  static BmiCategory fromBmi(double bmi) {
    if (bmi < 18.5) {
      return BmiCategory.underweight;
    } else if (bmi < 25.0) {
      return BmiCategory.normal;
    } else if (bmi < 30.0) {
      return BmiCategory.overweight;
    } else if (bmi < 35.0) {
      return BmiCategory.obeseClass1;
    } else {
      return BmiCategory.obeseClass2;
    }
  }
}
