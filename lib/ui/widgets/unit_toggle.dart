import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class UnitToggle<T> extends StatelessWidget {
  final T selectedValue;
  final T option1Value;
  final String option1Label;
  final T option2Value;
  final String option2Label;
  final ValueChanged<T> onChanged;

  const UnitToggle({
    super.key,
    required this.selectedValue,
    required this.option1Value,
    required this.option1Label,
    required this.option2Value,
    required this.option2Label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isOption1 = selectedValue == option1Value;

    return Container(
      height: 30,
      padding: const EdgeInsets.all(2.5),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F5F7),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Option 1
          GestureDetector(
            onTap: () => onChanged(option1Value),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
              decoration: BoxDecoration(
                color: isOption1 ? AppColors.coralPrimary : Colors.transparent,
                borderRadius: BorderRadius.circular(13),
                boxShadow: isOption1
                    ? [
                        BoxShadow(
                          color: AppColors.coralPrimary.withValues(alpha: 0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: Text(
                  option1Label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: isOption1 ? FontWeight.w700 : FontWeight.w600,
                    color: isOption1 ? Colors.white : AppColors.textLightGray,
                  ),
                ),
              ),
            ),
          ),

          // Option 2
          GestureDetector(
            onTap: () => onChanged(option2Value),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
              decoration: BoxDecoration(
                color: !isOption1 ? AppColors.coralPrimary : Colors.transparent,
                borderRadius: BorderRadius.circular(13),
                boxShadow: !isOption1
                    ? [
                        BoxShadow(
                          color: AppColors.coralPrimary.withValues(alpha: 0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: Text(
                  option2Label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: !isOption1 ? FontWeight.w700 : FontWeight.w600,
                    color: !isOption1 ? Colors.white : AppColors.textLightGray,
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
