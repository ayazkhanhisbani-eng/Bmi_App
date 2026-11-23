import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../models/bmi_category.dart';
import '../theme/app_colors.dart';

class BmiGauge extends StatefulWidget {
  final double bmi;
  final BmiCategory category;

  const BmiGauge({
    super.key,
    required this.bmi,
    required this.category,
  });

  @override
  State<BmiGauge> createState() => _BmiGaugeState();
}

class _BmiGaugeState extends State<BmiGauge> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant BmiGauge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.bmi != widget.bmi) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Arc & Needle
        SizedBox(
          width: 280,
          height: 160,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, _) {
              final animatedBmi = 15.0 + (widget.bmi - 15.0) * _animation.value;
              return CustomPaint(
                size: const Size(280, 160),
                painter: _BmiGaugePainter(
                  bmi: animatedBmi,
                  categoryColor: widget.category.color,
                ),
              );
            },
          ),
        ),

        // BMI Value & Category Name
        Transform.translate(
          offset: const Offset(0, -10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.bmi.toStringAsFixed(1),
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  color: widget.category.color,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                widget.category.label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: widget.category.color,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        // 2-row Category Legend matching the reference image
        _buildLegend(),
      ],
    );
  }

  Widget _buildLegend() {
    return Column(
      children: [
        // Row 1: Underweight, Normal, Overweight
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _LegendItem(
              color: AppColors.underweight,
              label: 'Underweight',
              isActive: widget.category == BmiCategory.underweight,
            ),
            const SizedBox(width: 16),
            _LegendItem(
              color: AppColors.normal,
              label: 'Normal',
              isActive: widget.category == BmiCategory.normal,
            ),
            const SizedBox(width: 16),
            _LegendItem(
              color: AppColors.overweight,
              label: 'Overweight',
              isActive: widget.category == BmiCategory.overweight,
            ),
          ],
        ),
        const SizedBox(height: 10),
        // Row 2: Obese class I, Obese class II
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _LegendItem(
              color: AppColors.obese1,
              label: 'Obese class I',
              isActive: widget.category == BmiCategory.obeseClass1,
            ),
            const SizedBox(width: 18),
            _LegendItem(
              color: AppColors.obese2,
              label: 'Obese class II',
              isActive: widget.category == BmiCategory.obeseClass2,
            ),
          ],
        ),
      ],
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final bool isActive;

  const _LegendItem({
    required this.color,
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: color.withValues(alpha: 0.5),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            color: isActive ? AppColors.textDark : AppColors.textGray,
          ),
        ),
      ],
    );
  }
}

class _BmiGaugePainter extends CustomPainter {
  final double bmi;
  final Color categoryColor;

  _BmiGaugePainter({
    required this.bmi,
    required this.categoryColor,
  });

  // Segments definition: (startBmi, endBmi, color, labelText)
  static final List<({double start, double end, Color color})> segments = [
    (start: 15.0, end: 18.5, color: AppColors.underweight),
    (start: 18.5, end: 25.0, color: AppColors.normal),
    (start: 25.0, end: 30.0, color: AppColors.overweight),
    (start: 30.0, end: 35.0, color: AppColors.obese1),
    (start: 35.0, end: 40.0, color: AppColors.obese2),
  ];

  static const double minBmi = 15.0;
  static const double maxBmi = 40.0;

  double _bmiToAngle(double value) {
    final clamped = value.clamp(minBmi, maxBmi);
    final t = (clamped - minBmi) / (maxBmi - minBmi);
    // Arc runs from math.pi (180 deg) down to 0 (0 deg)
    return math.pi - (t * math.pi);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height - 15);
    final outerRadius = size.width * 0.44;
    final strokeWidth = size.width * 0.088;
    final arcRadius = outerRadius - strokeWidth / 2;

    final arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    final gapAngle = 0.035; // radians gap between segments

    // 1. Draw each colorful segment
    for (final seg in segments) {
      final startAngle = _bmiToAngle(seg.start);
      final endAngle = _bmiToAngle(seg.end);

      // In Flutter, arc angles are clockwise:
      final sweep = (endAngle - startAngle);
      final adjustedStart = startAngle - (gapAngle / 2);
      final adjustedSweep = sweep + gapAngle;

      arcPaint.color = seg.color;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: arcRadius),
        adjustedStart,
        adjustedSweep,
        false,
        arcPaint,
      );
    }

    // 2. Draw BMI boundary numbers along outer edge
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final boundaryValues = [15.0, 18.5, 25.0, 30.0, 35.0, 40.0];

    for (final val in boundaryValues) {
      final angle = _bmiToAngle(val);
      final labelRadius = outerRadius + 14;
      final x = center.dx + labelRadius * math.cos(angle);
      final y = center.dy - labelRadius * math.sin(angle);

      textPainter.text = TextSpan(
        text: val.toStringAsFixed(1),
        style: const TextStyle(
          fontSize: 9.5,
          fontWeight: FontWeight.w600,
          color: AppColors.textGray,
        ),
      );
      textPainter.layout();

      final textOffset = Offset(
        x - textPainter.width / 2,
        y - textPainter.height / 2,
      );
      textPainter.paint(canvas, textOffset);
    }

    // 3. Draw Needle / Pointer
    final needleAngle = _bmiToAngle(bmi);
    final needleTipRadius = arcRadius - strokeWidth / 2 - 2;
    final needleBaseRadius = arcRadius - strokeWidth / 2 - 24;

    final needleTip = Offset(
      center.dx + needleTipRadius * math.cos(needleAngle),
      center.dy - needleTipRadius * math.sin(needleAngle),
    );

    final perpAngle = needleAngle + math.pi / 2;
    final halfBase = 7.0;

    final baseCenter = Offset(
      center.dx + needleBaseRadius * math.cos(needleAngle),
      center.dy - needleBaseRadius * math.sin(needleAngle),
    );

    final baseLeft = Offset(
      baseCenter.dx + halfBase * math.cos(perpAngle),
      baseCenter.dy - halfBase * math.sin(perpAngle),
    );

    final baseRight = Offset(
      baseCenter.dx - halfBase * math.cos(perpAngle),
      baseCenter.dy - halfBase * math.sin(perpAngle),
    );

    final needlePath = Path()
      ..moveTo(needleTip.dx, needleTip.dy)
      ..lineTo(baseLeft.dx, baseLeft.dy)
      ..lineTo(baseRight.dx, baseRight.dy)
      ..close();

    final needlePaint = Paint()
      ..color = const Color(0xFF1E212B)
      ..style = PaintingStyle.fill;

    // Needle shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    canvas.drawPath(needlePath.shift(const Offset(0, 2)), shadowPaint);

    canvas.drawPath(needlePath, needlePaint);
  }

  @override
  bool shouldRepaint(covariant _BmiGaugePainter oldDelegate) {
    return oldDelegate.bmi != bmi || oldDelegate.categoryColor != categoryColor;
  }
}
