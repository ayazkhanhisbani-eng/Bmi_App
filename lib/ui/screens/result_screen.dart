import 'package:flutter/material.dart';
import '../../models/bmi_data.dart';
import '../../models/bmi_category.dart';
import '../theme/app_colors.dart';
import '../widgets/app_logo.dart';
import '../widgets/bmi_gauge.dart';
import '../widgets/recommendation_card.dart';
import '../widgets/gradient_button.dart';

class ResultScreen extends StatelessWidget {
  final BmiCalculationResult result;

  const ResultScreen({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final category = BmiCategory.fromBmi(result.bmi);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable main body
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 12),

                    // Top Brand Logo
                    const Center(
                      child: AppLogo(scale: 1.0),
                    ),
                    const SizedBox(height: 20),

                    // Summary Row of 3 Pill Badges
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSummaryPill(
                          icon: Icons.monitor_weight_outlined,
                          text: result.formattedWeight,
                        ),
                        const SizedBox(width: 8),
                        _buildSummaryPill(
                          icon: Icons.height,
                          text: result.formattedHeight,
                        ),
                        const SizedBox(width: 8),
                        _buildSummaryPill(
                          icon: Icons.sentiment_satisfied_alt_rounded,
                          text: result.formattedAge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Colorful Speedometer BMI Gauge
                    BmiGauge(
                      bmi: result.bmi,
                      category: category,
                    ),
                    const SizedBox(height: 24),

                    // Recommendations Card
                    RecommendationCard(category: category),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Fixed Bottom Retry Button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: GradientButton(
                text: 'Retry',
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryPill({
    required IconData icon,
    required String text,
  }) {
    return Expanded(
      child: Container(
        height: 38,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: AppColors.coralBadgeBg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: AppColors.coralPrimary,
            ),
            const SizedBox(width: 5),
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.coralPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
