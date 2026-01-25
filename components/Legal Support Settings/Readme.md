# Glassmorphism Legal & Support UI

A premium, responsive Flutter component designed for **Desktop** and **Mobile**. This component features a modern "Glassmorphism" aesthetic with staggered entry animations, high-visibility tap feedback, and a responsive layout that centers as a mobile mockup on large screens.

## 🚀 Features

* **Responsive Layout**: Automatically switches between a centered "Phone Frame" (Desktop) and a full-screen view (Mobile/Tablet).
* **Staggered Animations**: Smooth vertical entry animations for list items using `Interval` curves.
* **Premium Interactions**: High-visibility tap logic including color shifts, glowing borders, and haptic scaling (0.95x).
* **Blur Overlay**: Integrated "Info" popup using `BackdropFilter` for a native frosted-glass effect.
* **Custom Theme Toggle**: A unique animated sun/moon toggle for Dark and Light mode transitions.

## 📦 Components Included

1.  **`AnimatedLegalSupportScreen`**: The main scaffold containing the responsive logic and animations.
2.  **`GlassThemeToggle`**: An animated custom switch for theme management.
3.  **`_SupportCard`**: An interactive card with hover and press states.
4.  **`_LegalTile`**: Specialized ListTiles for legal documentation links.

---

## 🛠️ Installation & Usage

### 1. Inject the component file
```bash
pui-inject Legal Support Settings
```

### 2. Implement main.dart
Use the following code to initialize the app and manage the theme state:

```dart
import 'package:flutter/material.dart';
import 'legal_support_screen.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Global state for Theme Management
  bool _isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Glassmorphism Support UI',
      // The component manages its own internal colors, 
      // but we set the brightness here for system-level consistency.
      theme: ThemeData(
        useMaterial3: true,
        brightness: _isDarkMode ? Brightness.dark : Brightness.light,
      ),
      home: AnimatedLegalSupportScreen(
        isDark: _isDarkMode,
        onThemeToggle: (val) {
          setState(() {
            _isDarkMode = val;
          });
        },
      ),
    );
  }
}