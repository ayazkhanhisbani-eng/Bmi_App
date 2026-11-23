import 'package:flutter/material.dart';
import '../../models/bmi_category.dart';
import '../theme/app_colors.dart';

class RecommendationCard extends StatelessWidget {
  final BmiCategory category;

  const RecommendationCard({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final recommendations = category.recommendations;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Icon Badge + Title
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.coralBadgeBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Icon(
                    Icons.eco_rounded,
                    size: 18,
                    color: AppColors.coralPrimary,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Our Recommendations',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.coralPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Bullet points
          ...recommendations.take(3).map((tip) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Icon(
                        Icons.check_circle,
                        size: 17,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        tip,
                        style: const TextStyle(
                          fontSize: 12,
                          height: 1.45,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
