import 'package:flutter/material.dart';
import '../../models/bmi_data.dart';
import '../../view_models/bmi_view_model.dart';
import '../theme/app_colors.dart';
import '../widgets/app_logo.dart';
import '../widgets/gender_card.dart';
import '../widgets/stepper_card.dart';
import '../widgets/height_slider_card.dart';
import '../widgets/unit_toggle.dart';
import '../widgets/gradient_button.dart';
import 'result_screen.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final BmiViewModel _viewModel = BmiViewModel();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  void _onCalculatePressed() {
    final result = _viewModel.calculateResult();
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) =>
            ResultScreen(result: result),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _viewModel,
          builder: (context, _) {
            final weightDisplay = _viewModel.weightUnit == WeightUnit.lb
                ? _viewModel.weight.round().toString()
                : _viewModel.weight.toStringAsFixed(1).replaceAll('.0', '');

            return Column(
              children: [
                // Scrollable main body
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),

                        // Top Brand Logo
                        const Center(
                          child: AppLogo(scale: 1.0),
                        ),
                        const SizedBox(height: 24),

                        // Screen Title
                        const Text(
                          'BMI Calculator',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textDark,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Gender Selection Row
                        Row(
                          children: [
                            Expanded(
                              child: GenderCard(
                                gender: Gender.male,
                                isSelected: _viewModel.gender == Gender.male,
                                onTap: () => _viewModel.setGender(Gender.male),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: GenderCard(
                                gender: Gender.female,
                                isSelected: _viewModel.gender == Gender.female,
                                onTap: () => _viewModel.setGender(Gender.female),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Interactive Inputs Grid
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left Column: Weight Card & Age Card
                            Expanded(
                              child: Column(
                                children: [
                                  // Weight Card
                                  StepperCard(
                                    icon: const Icon(
                                      Icons.monitor_weight_outlined,
                                      size: 17,
                                      color: AppColors.coralPrimary,
                                    ),
                                    title: 'Weight',
                                    displayValue: weightDisplay,
                                    onDecrement: _viewModel.decrementWeight,
                                    onIncrement: _viewModel.incrementWeight,
                                    bottomWidget: UnitToggle<WeightUnit>(
                                      selectedValue: _viewModel.weightUnit,
                                      option1Value: WeightUnit.lb,
                                      option1Label: 'LB',
                                      option2Value: WeightUnit.kg,
                                      option2Label: 'KG',
                                      onChanged: _viewModel.setWeightUnit,
                                    ),
                                  ),
                                  const SizedBox(height: 16),

                                  // Age Card
                                  StepperCard(
                                    icon: const Icon(
                                      Icons.sentiment_satisfied_alt_rounded,
                                      size: 18,
                                      color: AppColors.coralPrimary,
                                    ),
                                    title: 'Age',
                                    displayValue: _viewModel.age.toString(),
                                    onDecrement: _viewModel.decrementAge,
                                    onIncrement: _viewModel.incrementAge,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),

                            // Right Column: Height Slider Card (Spans full height)
                            Expanded(
                              child: SizedBox(
                                height: 320,
                                child: HeightSliderCard(
                                  heightValue: _viewModel.height,
                                  unit: _viewModel.heightUnit,
                                  onHeightChanged: _viewModel.setHeight,
                                  onUnitChanged: _viewModel.setHeightUnit,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),

                // Fixed Bottom Calculate Button
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  child: GradientButton(
                    text: 'Calculate',
                    onPressed: _onCalculatePressed,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
