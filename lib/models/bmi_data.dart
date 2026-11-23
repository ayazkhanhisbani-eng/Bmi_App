enum Gender { male, female }

enum WeightUnit { lb, kg }

enum HeightUnit { cm, ft }

class BmiCalculationResult {
  final double bmi;
  final Gender gender;
  final double displayWeight;
  final WeightUnit weightUnit;
  final double displayHeight;
  final HeightUnit heightUnit;
  final int age;

  const BmiCalculationResult({
    required this.bmi,
    required this.gender,
    required this.displayWeight,
    required this.weightUnit,
    required this.displayHeight,
    required this.heightUnit,
    required this.age,
  });

  String get formattedBmi => bmi.toStringAsFixed(1);

  String get formattedWeight {
    if (weightUnit == WeightUnit.lb) {
      return '${displayWeight.round()} LB';
    } else {
      return '${displayWeight.toStringAsFixed(1).replaceAll('.0', '')} KG';
    }
  }

  String get formattedHeight {
    if (heightUnit == HeightUnit.cm) {
      return '${displayHeight.round()} CM';
    } else {
      return '${displayHeight.toStringAsFixed(1)} FT';
    }
  }

  String get formattedAge => '$age Years';
}
