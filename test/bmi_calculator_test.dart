import 'package:flutter_test/flutter_test.dart';
import 'package:bmi_calculator/models/bmi_data.dart';
import 'package:bmi_calculator/models/bmi_category.dart';
import 'package:bmi_calculator/view_models/bmi_view_model.dart';

void main() {
  group('BMI Logic & ViewModel Tests', () {
    test('Default values match design reference mockup', () {
      final vm = BmiViewModel();
      expect(vm.gender, Gender.male);
      expect(vm.weight, 200.0);
      expect(vm.weightUnit, WeightUnit.lb);
      expect(vm.height, 170.0);
      expect(vm.heightUnit, HeightUnit.cm);
      expect(vm.age, 26);
    });

    test('Weight increment and decrement', () {
      final vm = BmiViewModel();
      vm.incrementWeight();
      expect(vm.weight, 201.0);
      vm.decrementWeight();
      expect(vm.weight, 200.0);
    });

    test('Weight unit conversion between LB and KG', () {
      final vm = BmiViewModel();
      vm.setWeightUnit(WeightUnit.kg);
      expect(vm.weightUnit, WeightUnit.kg);
      expect(vm.weight, 91.0);

      vm.setWeightUnit(WeightUnit.lb);
      expect(vm.weightUnit, WeightUnit.lb);
      expect(vm.weight, 201.0);
    });

    test('Height increment and decrement', () {
      final vm = BmiViewModel();
      vm.incrementHeight();
      expect(vm.height, 171.0);
      vm.decrementHeight();
      expect(vm.height, 170.0);
    });

    test('Height unit conversion between CM and FT', () {
      final vm = BmiViewModel();
      vm.setHeightUnit(HeightUnit.ft);
      expect(vm.heightUnit, HeightUnit.ft);
      expect(vm.height, 5.6);

      vm.setHeightUnit(HeightUnit.cm);
      expect(vm.heightUnit, HeightUnit.cm);
      expect(vm.height, 171.0);
    });

    test('Age increment and decrement', () {
      final vm = BmiViewModel();
      vm.incrementAge();
      expect(vm.age, 27);
      vm.decrementAge();
      expect(vm.age, 26);
    });

    test('Gender toggling', () {
      final vm = BmiViewModel();
      vm.setGender(Gender.female);
      expect(vm.gender, Gender.female);
      vm.setGender(Gender.male);
      expect(vm.gender, Gender.male);
    });

    test('BMI calculation math correctness', () {
      final vm = BmiViewModel();
      final result = vm.calculateResult();
      expect(result.bmi, closeTo(31.39, 0.1));
      expect(result.formattedBmi, '31.4');
      expect(result.formattedWeight, '200 LB');
      expect(result.formattedHeight, '170 CM');
      expect(result.formattedAge, '26 Years');
    });

    test('Normal BMI calculation test', () {
      final vm = BmiViewModel();
      vm.setWeightUnit(WeightUnit.kg);
      vm.setWeight(68.0);
      vm.setHeight(170.0);
      vm.setHeightUnit(HeightUnit.cm);

      final result = vm.calculateResult();
      expect(result.bmi, closeTo(23.5, 0.1));
      final cat = BmiCategory.fromBmi(result.bmi);
      expect(cat, BmiCategory.normal);
      expect(cat.label, 'Normal');
    });

    test('BMI Category thresholds', () {
      expect(BmiCategory.fromBmi(17.5), BmiCategory.underweight);
      expect(BmiCategory.fromBmi(18.5), BmiCategory.normal);
      expect(BmiCategory.fromBmi(24.9), BmiCategory.normal);
      expect(BmiCategory.fromBmi(25.0), BmiCategory.overweight);
      expect(BmiCategory.fromBmi(29.9), BmiCategory.overweight);
      expect(BmiCategory.fromBmi(30.0), BmiCategory.obeseClass1);
      expect(BmiCategory.fromBmi(34.9), BmiCategory.obeseClass1);
      expect(BmiCategory.fromBmi(35.0), BmiCategory.obeseClass2);
      expect(BmiCategory.fromBmi(42.0), BmiCategory.obeseClass2);
    });

    test('Recommendations available for all categories', () {
      for (final cat in BmiCategory.values) {
        expect(cat.recommendations.length, greaterThanOrEqualTo(3));
        expect(cat.label.isNotEmpty, true);
        expect(cat.rangeString.isNotEmpty, true);
      }
    });
  });
}
