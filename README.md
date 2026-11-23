# 🩺 BMI Calculator — Flutter App

A modern, responsive, and pixel-perfect Flutter BMI Calculator application designed with a coral-orange gradient aesthetic, 5-segment WHO speedometer gauge, interactive controls, and dynamic health recommendations.

🌐 **Live Demo:** [https://ayazkhanhisbani-eng.github.io/Bmi_App/](https://ayazkhanhisbani-eng.github.io/Bmi_App/)

---

## ✨ Features

- **🎨 Modern Coral-Orange Gradient UI:** Faithful implementation of the coral gradient (`#FF8B66` to `#FF5238`), crisp white rounded cards, soft drop shadows, and warm peach badge accents.
- **⚡ Branded Splash Screen:** Interactive startup experience with animated pulsing scale icon, stylized wireframe logo, and smooth auto-navigation.
- **🚻 Gender Selector:** Side-by-side cards with custom vector avatar illustrations for Male and Female, featuring a coral active border and speech-bubble notch with a white checkmark (`✓`).
- **⚖️ Weight Stepper:** Tap or hold `-` and `+` buttons for rapid auto-repeat, paired with an animated unit toggle (**LB** / **KG**) and automatic unit conversion.
- **📏 Height Slider Card:** Spans alongside the Weight and Age cards with a large bold readout, draggable vertical slider track with triangle pointer, and **CM** / **FT** unit toggle.
- **🎂 Age Stepper:** Interactive stepper controls with hold-to-repeat functionality.
- **📊 5-Segment Speedometer BMI Gauge:**
  - 🔵 **Underweight** (< 18.5) — Sky Blue
  - 🟢 **Normal** (18.5 – 24.9) — Emerald Green
  - 🟡 **Overweight** (25.0 – 29.9) — Golden Yellow
  - 🟠 **Obese class I** (30.0 – 34.9) — Orange
  - 🔴 **Obese class II** (≥ 35.0) — Red
  - Features an animated indicator needle, outer boundary markers, and 2-row category legend.
- **💡 Tailored Health Recommendations:** Category-specific medical and wellness advice checklist.
- **🔄 Recalculate / Retry:** Instant recalculation flow with smooth slide transitions.
- **📱 Fully Responsive & Cross-Platform:** Runs seamlessly on Web, Android, iOS, Windows, macOS, and Linux.

---

## 🏗️ Architecture & Code Structure

```text
lib/
├── models/
│   ├── bmi_category.dart      # WHO categories, colors, ranges & recommendations
│   └── bmi_data.dart          # Data structures & calculation result model
├── view_models/
│   └── bmi_view_model.dart    # State management, unit conversions & formula logic
├── ui/
│   ├── theme/
│   │   ├── app_colors.dart    # Palette, gradients, card & button shadows
│   │   └── app_theme.dart     # Poppins typography & Light ThemeData
│   ├── widgets/
│   │   ├── app_logo.dart           # Custom outline BMI logo painter
│   │   ├── gender_card.dart        # Vector avatar illustrations & speech bubble notch
│   │   ├── stepper_card.dart       # Stepper with long-press auto-increment
│   │   ├── height_slider_card.dart # Vertical slider with triangle pointer
│   │   ├── unit_toggle.dart        # Animated dual-unit pill toggle
│   │   ├── bmi_gauge.dart          # 5-segment speedometer arc with needle & legend
│   │   ├── recommendation_card.dart# Category-tailored advice checklist
│   │   └── gradient_button.dart    # Coral-orange gradient action button
│   └── screens/
│       ├── splash_screen.dart      # Branded animated splash screen
│       ├── calculator_screen.dart  # Main input dashboard
│       └── result_screen.dart      # Results, gauge, and recommendations
└── main.dart
```

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.x or later)
- Dart SDK (3.x or later)

### Installation & Run

1. Clone the repository:
   ```bash
   git clone https://github.com/ayazkhanhisbani-eng/Bmi_App.git
   cd Bmi_App
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run automated tests:
   ```bash
   flutter test
   ```

4. Launch the application:
   ```bash
   # On Chrome (Web)
   flutter run -d chrome

   # On Windows Desktop
   flutter run -d windows
   ```

---

## 🧪 Testing

The repository contains a test suite covering:
- Unit tests for all BMI formulas and unit conversions (LB <-> KG, CM <-> FT)
- WHO BMI category thresholds and recommendation mapping
- Widget tests for splash screen auto-transition, form interactions, and result view

```bash
flutter test
```
All 14 tests pass with 0 warnings on `flutter analyze`.

---

## 📄 License
This project is open source and available under the [MIT License](LICENSE).
