import 'package:flutter/material.dart';
import '../../models/bmi_data.dart';
import '../theme/app_colors.dart';

class GenderCard extends StatelessWidget {
  final Gender gender;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderCard({
    super.key,
    required this.gender,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isMale = gender == Gender.male;
    final label = isMale ? 'Male' : 'Female';

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Main Card
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            height: 72,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: isSelected ? AppColors.coralBorder : Colors.transparent,
                width: isSelected ? 2.0 : 1.0,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.coralPrimary.withValues(alpha: 0.12),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Avatar Illustration
                SizedBox(
                  width: 38,
                  height: 38,
                  child: CustomPaint(
                    painter: isMale ? _MaleAvatarPainter() : _FemaleAvatarPainter(),
                  ),
                ),
                const SizedBox(width: 14),
                // Label
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                    color: isSelected ? AppColors.coralPrimary : AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),

          // Speech bubble notch with checkmark when selected
          if (isSelected)
            Positioned(
              left: 20,
              bottom: -10,
              child: CustomPaint(
                size: const Size(22, 14),
                painter: _BubbleTailPainter(color: AppColors.coralBorder),
                child: const SizedBox(
                  width: 22,
                  height: 14,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 1, left: 1),
                      child: Icon(
                        Icons.check,
                        size: 11,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Custom painter for the speech-bubble tail that appears under the selected gender card
class _BubbleTailPainter extends CustomPainter {
  final Color color;

  const _BubbleTailPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Draw speech bubble triangle/pill pointing downward
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..quadraticBezierTo(
        size.width * 0.8,
        size.height * 0.8,
        size.width * 0.3,
        size.height,
      )
      ..quadraticBezierTo(
        size.width * 0.1,
        size.height * 0.8,
        0,
        0,
      )
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _BubbleTailPainter oldDelegate) =>
      oldDelegate.color != color;
}

/// Vector Male Avatar matching the UI mockup:
/// Dark hair, friendly face, blue crewneck / collared shirt
class _MaleAvatarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Shirt (Blue)
    final shirtPaint = Paint()..color = const Color(0xFF2D3B82);
    final shirtPath = Path()
      ..moveTo(w * 0.15, h * 0.95)
      ..quadraticBezierTo(w * 0.25, h * 0.68, w * 0.35, h * 0.7)
      ..lineTo(w * 0.5, h * 0.78)
      ..lineTo(w * 0.65, h * 0.7)
      ..quadraticBezierTo(w * 0.75, h * 0.68, w * 0.85, h * 0.95)
      ..close();
    canvas.drawPath(shirtPath, shirtPaint);

    // 2. Neck
    final skinPaint = Paint()..color = const Color(0xFFFFD1A9);
    final neckRect = Rect.fromLTWH(w * 0.42, h * 0.58, w * 0.16, h * 0.18);
    canvas.drawRect(neckRect, skinPaint);

    // 3. Head / Face
    final facePaint = Paint()..color = const Color(0xFFFFE0BD);
    final faceRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.3, h * 0.26, w * 0.4, h * 0.42),
      const Radius.circular(8),
    );
    canvas.drawRRect(faceRect, facePaint);

    // 4. Ears
    final earPaint = Paint()..color = const Color(0xFFFFD1A9);
    canvas.drawCircle(Offset(w * 0.28, h * 0.46), w * 0.055, earPaint);
    canvas.drawCircle(Offset(w * 0.72, h * 0.46), w * 0.055, earPaint);

    // 5. Hair (Dark charcoal / black stylish quiff)
    final hairPaint = Paint()..color = const Color(0xFF1E212B);
    final hairPath = Path()
      ..moveTo(w * 0.28, h * 0.36)
      ..quadraticBezierTo(w * 0.28, h * 0.12, w * 0.5, h * 0.12)
      ..quadraticBezierTo(w * 0.72, h * 0.12, w * 0.72, h * 0.36)
      ..lineTo(w * 0.68, h * 0.3)
      ..lineTo(w * 0.5, h * 0.22)
      ..lineTo(w * 0.32, h * 0.3)
      ..close();
    canvas.drawPath(hairPath, hairPaint);

    // 6. Facial details: eyes & smile
    final featurePaint = Paint()
      ..color = const Color(0xFF333333)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.6;

    // Eyes
    canvas.drawCircle(Offset(w * 0.41, h * 0.45), 1.2, featurePaint);
    canvas.drawCircle(Offset(w * 0.59, h * 0.45), 1.2, featurePaint);

    // Smile
    final smilePath = Path()
      ..moveTo(w * 0.45, h * 0.54)
      ..quadraticBezierTo(w * 0.5, h * 0.58, w * 0.55, h * 0.54);
    final smilePaint = Paint()
      ..color = const Color(0xFFE27B58)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.4;
    canvas.drawPath(smilePath, smilePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Vector Female Avatar matching the UI mockup:
/// Auburn/reddish hair, friendly face, blue top
class _FemaleAvatarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Back hair (Auburn/warm ginger-orange)
    final hairPaint = Paint()..color = const Color(0xFFE77A4D);
    final backHairPath = Path()
      ..moveTo(w * 0.22, h * 0.3)
      ..quadraticBezierTo(w * 0.2, h * 0.75, w * 0.26, h * 0.85)
      ..lineTo(w * 0.36, h * 0.85)
      ..lineTo(w * 0.36, h * 0.5)
      ..lineTo(w * 0.64, h * 0.5)
      ..lineTo(w * 0.64, h * 0.85)
      ..lineTo(w * 0.74, h * 0.85)
      ..quadraticBezierTo(w * 0.8, h * 0.75, w * 0.78, h * 0.3)
      ..quadraticBezierTo(w * 0.5, h * 0.08, w * 0.22, h * 0.3)
      ..close();
    canvas.drawPath(backHairPath, hairPaint);

    // 2. Neck & Skin
    final skinPaint = Paint()..color = const Color(0xFFFFD6B2);
    final neckRect = Rect.fromLTWH(w * 0.43, h * 0.56, w * 0.14, h * 0.18);
    canvas.drawRect(neckRect, skinPaint);

    // 3. Top (Blue)
    final topPaint = Paint()..color = const Color(0xFF386FA4);
    final topPath = Path()
      ..moveTo(w * 0.2, h * 0.95)
      ..quadraticBezierTo(w * 0.32, h * 0.72, w * 0.42, h * 0.72)
      ..quadraticBezierTo(w * 0.5, h * 0.8, w * 0.58, h * 0.72)
      ..quadraticBezierTo(w * 0.68, h * 0.72, w * 0.8, h * 0.95)
      ..close();
    canvas.drawPath(topPath, topPaint);

    // 4. Head / Face
    final facePaint = Paint()..color = const Color(0xFFFFE5CB);
    final faceRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.32, h * 0.28, w * 0.36, h * 0.4),
      const Radius.circular(8),
    );
    canvas.drawRRect(faceRect, facePaint);

    // 5. Front bangs
    final frontHairPath = Path()
      ..moveTo(w * 0.28, h * 0.3)
      ..quadraticBezierTo(w * 0.5, h * 0.15, w * 0.72, h * 0.3)
      ..quadraticBezierTo(w * 0.6, h * 0.32, w * 0.48, h * 0.24)
      ..quadraticBezierTo(w * 0.38, h * 0.32, w * 0.28, h * 0.3)
      ..close();
    canvas.drawPath(frontHairPath, hairPaint);

    // 6. Facial details
    final featurePaint = Paint()
      ..color = const Color(0xFF333333)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.6;

    // Eyes
    canvas.drawCircle(Offset(w * 0.42, h * 0.46), 1.2, featurePaint);
    canvas.drawCircle(Offset(w * 0.58, h * 0.46), 1.2, featurePaint);

    // Smile
    final smilePath = Path()
      ..moveTo(w * 0.46, h * 0.54)
      ..quadraticBezierTo(w * 0.5, h * 0.57, w * 0.54, h * 0.54);
    final smilePaint = Paint()
      ..color = const Color(0xFFE27B58)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.3;
    canvas.drawPath(smilePath, smilePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
