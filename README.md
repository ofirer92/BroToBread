# BroToBread - מחשבון לחם אומן

A mobile-friendly Flutter web application for artisan bread baking calculations and timers. Features Hebrew localization and beautiful, responsive UI design.

## 🌐 Live Demo

Visit the live app at: **[https://ofirer92.github.io/BroToBread/](https://ofirer92.github.io/BroToBread/)**

## ✨ Features

### Recipe Calculator
- **Multi-flour support**: Add and manage multiple types of flour
- **Hydration calculation**: Automatic hydration percentage based on total water content
- **Baker's percentages**: Calculate salt and starter percentages
- **Sourdough support**: Accounts for water and flour in starter (50/50 ratio)
- **Expected bread weight**: Calculates final weight after 15% water loss during baking

### Bread Timers
- **Preparation timers**:
  - Autolyse (30 min)
  - Mixing (15 min)
  - Bulk fermentation with stretch-and-fold reminders (240 min)
- **Baking timers**:
  - Bake with lid (20 min)
  - Bake without lid (20 min)
- **Customizable durations**: Edit timer settings to match your recipe
- **Fold notifications**: Automatic reminders for stretch-and-fold during bulk fermentation

### Mobile-Optimized UX
- Responsive design with 360px breakpoint for small screens
- Touch-friendly controls (minimum 40x40dp touch targets)
- Adaptive text sizes and spacing
- SafeArea support for notched devices
- Optimized for both mobile and desktop

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.24.0 or later)
- Dart SDK
- A code editor (VS Code, Android Studio, etc.)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/ofirer92/BroToBread.git
cd BroToBread
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
# Web
flutter run -d chrome

# Mobile
flutter run
```

### Build for Web

```bash
flutter build web --release
```

## 📱 Supported Platforms

- ✅ Web (Chrome, Safari, Firefox, Edge)
- ✅ Android
- ✅ iOS
- ✅ macOS
- ✅ Windows
- ✅ Linux

## 🎨 Design

The app features a warm, bread-themed color scheme with:
- Primary color: Amber-700 (#B45309)
- Secondary color: Amber-900 (#78350F)
- Background: Amber-50 (#FEF3C7)
- Hebrew Heebo font family for proper RTL support

## 🌍 Localization

- Fully localized in Hebrew (עברית)
- RTL (Right-to-Left) layout support
- Custom localization system

## 🔧 Technologies

- **Flutter**: UI framework
- **Material Design 3**: Design system
- **Custom animations**: Welcome screen animations
- **State management**: StatefulWidget with setState

## 📦 Deployment

The app is automatically deployed to GitHub Pages via GitHub Actions on every push to the main branch.

### Manual Deployment

1. Ensure GitHub Pages is enabled in repository settings
2. Push to main/master branch
3. GitHub Actions will automatically build and deploy

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is open source and available under the MIT License.

## 👨‍💻 Author

Created with ❤️ for bread baking enthusiasts

---

**Note**: This app is designed to help with artisan bread baking calculations. For best results, adjust timers and percentages based on your specific recipe and environmental conditions.
