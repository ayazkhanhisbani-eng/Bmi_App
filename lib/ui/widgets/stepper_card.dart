import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class StepperCard extends StatelessWidget {
  final Widget icon;
  final String title;
  final String displayValue;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final Widget? bottomWidget;

  const StepperCard({
    super.key,
    required this.icon,
    required this.title,
    required this.displayValue,
    required this.onDecrement,
    required this.onIncrement,
    this.bottomWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(24),
        boxShadow: AppColors.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
                child: Center(child: icon),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.coralPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Stepper: [-] Number [+]
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _RepeatableButton(
                icon: Icons.remove,
                onPressed: onDecrement,
              ),
              const SizedBox(width: 12),
              Text(
                displayValue,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(width: 12),
              _RepeatableButton(
                icon: Icons.add,
                onPressed: onIncrement,
              ),
            ],
          ),

          // Bottom widget (e.g. Unit toggle)
          if (bottomWidget != null) ...[
            const SizedBox(height: 16),
            bottomWidget!,
          ],
        ],
      ),
    );
  }
}

/// Circular button with rapid auto-repeat on long-press
class _RepeatableButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _RepeatableButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_RepeatableButton> createState() => _RepeatableButtonState();
}

class _RepeatableButtonState extends State<_RepeatableButton> {
  Timer? _timer;
  bool _isPressed = false;

  void _startTimer() {
    widget.onPressed();
    _timer = Timer(const Duration(milliseconds: 300), () {
      _timer = Timer.periodic(const Duration(milliseconds: 70), (_) {
        widget.onPressed();
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        _startTimer();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        _stopTimer();
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
        _stopTimer();
      },
      child: AnimatedScale(
        scale: _isPressed ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.stepperBtnBorder,
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Icon(
            widget.icon,
            size: 16,
            color: AppColors.textDark,
          ),
        ),
      ),
    );
  }
}
