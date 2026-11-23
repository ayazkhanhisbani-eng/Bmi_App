import 'package:flutter/material.dart';
import '../../models/bmi_data.dart';
import '../theme/app_colors.dart';
import 'unit_toggle.dart';

class HeightSliderCard extends StatelessWidget {
  final double heightValue;
  final HeightUnit unit;
  final ValueChanged<double> onHeightChanged;
  final ValueChanged<HeightUnit> onUnitChanged;

  const HeightSliderCard({
    super.key,
    required this.heightValue,
    required this.unit,
    required this.onHeightChanged,
    required this.onUnitChanged,
  });

  double get _min => unit == HeightUnit.cm ? 90.0 : 3.0;
  double get _max => unit == HeightUnit.cm ? 230.0 : 7.6;

  @override
  Widget build(BuildContext context) {
    final displayNum = unit == HeightUnit.cm
        ? heightValue.round().toString()
        : heightValue.toStringAsFixed(1);

    final unitLabel = unit == HeightUnit.cm ? 'CM' : 'FT';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        children: [
          // Header: Icon badge + Title
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                    Icons.height,
                    size: 18,
                    color: AppColors.coralPrimary,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Height',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.coralPrimary,
                ),
              ),
            ],
          ),

          // Body with value on left and vertical slider on right
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Value and Unit
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayNum,
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDark,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      unitLabel,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textLightGray,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),

                // Vertical slider track with triangular pointer
                Center(
                  child: SizedBox(
                    width: 50,
                    child: _VerticalSlider(
                      value: heightValue.clamp(_min, _max),
                      min: _min,
                      max: _max,
                      height: 140,
                      onChanged: onHeightChanged,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Unit Toggle
          UnitToggle<HeightUnit>(
            selectedValue: unit,
            option1Value: HeightUnit.cm,
            option1Label: 'CM',
            option2Value: HeightUnit.ft,
            option2Label: 'FT',
            onChanged: onUnitChanged,
          ),
        ],
      ),
    );
  }
}

class _VerticalSlider extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final double height;
  final ValueChanged<double> onChanged;

  const _VerticalSlider({
    required this.value,
    required this.min,
    required this.max,
    required this.height,
    required this.onChanged,
  });

  void _handleDrag(Offset localPosition) {
    // 0 is top (max value), height is bottom (min value)
    final clampedDy = localPosition.dy.clamp(0.0, height);
    final progress = 1.0 - (clampedDy / height);
    final newValue = min + progress * (max - min);
    onChanged(newValue);
  }

  @override
  Widget build(BuildContext context) {
    final progress = ((value - min) / (max - min)).clamp(0.0, 1.0);
    final thumbY = (1.0 - progress) * height;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onVerticalDragUpdate: (details) => _handleDrag(details.localPosition),
      onTapDown: (details) => _handleDrag(details.localPosition),
      child: SizedBox(
        width: 44,
        height: height,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // Vertical track
            Container(
              width: 5,
              height: height,
              decoration: BoxDecoration(
                color: const Color(0xFFFFECE5),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 5,
                  height: height * progress,
                  decoration: BoxDecoration(
                    color: AppColors.coralPrimary,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),

            // Triangle Pointer / Thumb pointing to the track
            Positioned(
              left: 14,
              top: (thumbY - 7).clamp(0.0, height - 14),
              child: CustomPaint(
                size: const Size(12, 14),
                painter: _TrianglePointerPainter(color: AppColors.coralPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TrianglePointerPainter extends CustomPainter {
  final Color color;

  _TrianglePointerPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Triangle pointing to the left toward the slider track
    final path = Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _TrianglePointerPainter oldDelegate) =>
      oldDelegate.color != color;
}
