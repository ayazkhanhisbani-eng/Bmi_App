import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Renders the signature "BMI CALCULATOR" logo seen in the design reference.
/// It features the distinct outline/double-stroke letterform for "BMI",
/// followed by "CALCULATOR" and the subtle subtitle.
class AppLogo extends StatelessWidget {
  final double scale;
  final bool showSubtitle;

  const AppLogo({
    super.key,
    this.scale = 1.0,
    this.showSubtitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // "BMI" outline/layered typography
        SizedBox(
          height: 28 * scale,
          child: CustomPaint(
            size: Size(80 * scale, 28 * scale),
            painter: _BmiLogoPainter(),
          ),
        ),
        SizedBox(height: 3 * scale),
        Text(
          'CALCULATOR',
          style: TextStyle(
            fontSize: 10 * scale,
            fontWeight: FontWeight.w800,
            letterSpacing: 2.5 * scale,
            color: AppColors.textDark,
            fontFamily: 'sans-serif',
          ),
        ),
        if (showSubtitle) ...[
          SizedBox(height: 1 * scale),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'by ',
                style: TextStyle(
                  fontSize: 6.5 * scale,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textLightGray,
                  letterSpacing: 0.5 * scale,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 2.5 * scale,
                  vertical: 0.5 * scale,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.textLightGray,
                    width: 0.5 * scale,
                  ),
                  borderRadius: BorderRadius.circular(2 * scale),
                ),
                child: Text(
                  'DOSUSOFT',
                  style: TextStyle(
                    fontSize: 6 * scale,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8 * scale,
                    color: AppColors.textGray,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _BmiLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final scaleX = size.width / 80;
    final scaleY = size.height / 28;

    final outerStroke = Paint()
      ..color = AppColors.textDark
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2 * scaleX
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final innerStroke = Paint()
      ..color = AppColors.textDark
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0 * scaleX
      ..strokeCap = StrokeCap.round;

    canvas.save();
    canvas.scale(scaleX, scaleY);

    // Letter 'B'
    // Outer frame of B
    final bPath = Path()
      ..moveTo(5, 3)
      ..lineTo(18, 3)
      ..arcToPoint(const Offset(18, 14), radius: const Radius.circular(5.5))
      ..lineTo(5, 14)
      ..lineTo(19, 14)
      ..arcToPoint(const Offset(19, 25), radius: const Radius.circular(5.5))
      ..lineTo(5, 25)
      ..close();
    canvas.drawPath(bPath, outerStroke);

    // Inner line of B
    final bInnerPath = Path()
      ..moveTo(9, 7)
      ..lineTo(15, 7)
      ..arcToPoint(const Offset(15, 11), radius: const Radius.circular(2))
      ..lineTo(9, 11)
      ..close()
      ..moveTo(9, 17)
      ..lineTo(15, 17)
      ..arcToPoint(const Offset(15, 21), radius: const Radius.circular(2))
      ..lineTo(9, 21)
      ..close();
    canvas.drawPath(bInnerPath, innerStroke);

    // Letter 'M'
    final mPath = Path()
      ..moveTo(30, 25)
      ..lineTo(30, 3)
      ..lineTo(40, 15)
      ..lineTo(50, 3)
      ..lineTo(50, 25);
    canvas.drawPath(mPath, outerStroke);

    final mInnerPath = Path()
      ..moveTo(34, 25)
      ..lineTo(34, 9)
      ..lineTo(40, 18)
      ..lineTo(46, 9)
      ..lineTo(46, 25);
    canvas.drawPath(mInnerPath, innerStroke);

    // Letter 'I'
    final iPath = Path()
      ..moveTo(63, 3)
      ..lineTo(75, 3)
      ..moveTo(69, 3)
      ..lineTo(69, 25)
      ..moveTo(63, 25)
      ..lineTo(75, 25);
    canvas.drawPath(iPath, outerStroke);

    final iInnerPath = Path()
      ..moveTo(66, 7)
      ..lineTo(72, 7)
      ..moveTo(66, 21)
      ..lineTo(72, 21);
    canvas.drawPath(iInnerPath, innerStroke);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
