import 'package:flutter/foundation.dart';
import '../models/bmi_data.dart';
import '../models/bmi_category.dart';

class BmiViewModel extends ChangeNotifier {
  Gender _gender = Gender.male;
  double _weight = 200.0; // Default 200 LB as shown in reference
  WeightUnit _weightUnit = WeightUnit.lb;
  double _height = 170.0; // Default 170 CM as shown in reference
  HeightUnit _heightUnit = HeightUnit.cm;
  int _age = 26; // Default 26 as shown in reference

  Gender get gender => _gender;
  double get weight => _weight;
  WeightUnit get weightUnit => _weightUnit;
  double get height => _height;
  HeightUnit get heightUnit => _heightUnit;
  int get age => _age;

  void setGender(Gender newGender) {
    if (_gender != newGender) {
      _gender = newGender;
      notifyListeners();
    }
  }

  void setWeight(double newWeight) {
    final clamped = newWeight.clamp(
      _weightUnit == WeightUnit.lb ? 40.0 : 20.0,
      _weightUnit == WeightUnit.lb ? 500.0 : 250.0,
    );
    if ((_weight - clamped).abs() > 0.01) {
      _weight = clamped;
      notifyListeners();
    }
  }

  void incrementWeight() {
    setWeight(_weight + 1.0);
  }

  void decrementWeight() {
    setWeight(_weight - 1.0);
  }

  void setWeightUnit(WeightUnit newUnit) {
    if (_weightUnit != newUnit) {
      if (newUnit == WeightUnit.kg) {
        // LB -> KG (1 lb = 0.453592 kg)
        _weight = (_weight * 0.45359237).roundToDouble();
      } else {
        // KG -> LB (1 kg = 2.20462 lb)
        _weight = (_weight * 2.20462262).roundToDouble();
      }
      _weightUnit = newUnit;
      notifyListeners();
    }
  }

  void setHeight(double newHeight) {
    final clamped = newHeight.clamp(
      _heightUnit == HeightUnit.cm ? 80.0 : 2.6,
      _heightUnit == HeightUnit.cm ? 240.0 : 8.0,
    );
    if ((_height - clamped).abs() > 0.01) {
      _height = clamped;
      notifyListeners();
    }
  }

  void incrementHeight() {
    if (_heightUnit == HeightUnit.cm) {
      setHeight(_height + 1.0);
    } else {
      setHeight(_height + 0.1);
    }
  }

  void decrementHeight() {
    if (_heightUnit == HeightUnit.cm) {
      setHeight(_height - 1.0);
    } else {
      setHeight(_height - 0.1);
    }
  }

  void setHeightUnit(HeightUnit newUnit) {
    if (_heightUnit != newUnit) {
      if (newUnit == HeightUnit.ft) {
        // CM -> FT (1 cm = 0.0328084 ft)
        _height = double.parse((_height * 0.0328084).toStringAsFixed(1));
      } else {
        // FT -> CM (1 ft = 30.48 cm)
        _height = (_height * 30.48).roundToDouble();
      }
      _heightUnit = newUnit;
      notifyListeners();
    }
  }

  void setAge(int newAge) {
    final clamped = newAge.clamp(5, 120);
    if (_age != clamped) {
      _age = clamped;
      notifyListeners();
    }
  }

  void incrementAge() {
    setAge(_age + 1);
  }

  void decrementAge() {
    setAge(_age - 1);
  }

  /// Calculates the BMI according to standard scientific formula
  BmiCalculationResult calculateResult() {
    // Convert weight to kg
    final weightKg = _weightUnit == WeightUnit.lb
        ? _weight * 0.45359237
        : _weight;

    // Convert height to meters
    final heightM = _heightUnit == HeightUnit.cm
        ? _height / 100.0
        : _height * 0.3048;

    final calculatedBmi = weightKg / (heightM * heightM);

    return BmiCalculationResult(
      bmi: calculatedBmi,
      gender: _gender,
      displayWeight: _weight,
      weightUnit: _weightUnit,
      displayHeight: _height,
      heightUnit: _heightUnit,
      age: _age,
    );
  }

  /// Convenience getter for category from current inputs
  BmiCategory get currentCategory {
    return BmiCategory.fromBmi(calculateResult().bmi);
  }

  void resetToDefaults() {
    _gender = Gender.male;
    _weight = 200.0;
    _weightUnit = WeightUnit.lb;
    _height = 170.0;
    _heightUnit = HeightUnit.cm;
    _age = 26;
    notifyListeners();
  }
}
