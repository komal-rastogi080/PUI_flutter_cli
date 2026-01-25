# 🔦 Universal Spotlight Navigation (Dual-Theme)

A high-fidelity, responsive navigation bar for Flutter. It features a dynamic "Spotlight Beam" that follows the active tab, with colors and geometry that adapt automatically to **Mobile, Tablet, and Desktop** screens, now featuring full **Light and Dark mode** support.

## ✨ Features
* **Dual-Theme Support:** Automatically switches between a deep charcoal bar for Dark mode and a clean white bar for Light mode based on system settings.
* **Adaptive Responsiveness:** Automatically adjusts bar width and icon spacing based on screen size (Capped at 500px for Desktop to maintain UI elegance).
* **Dynamic Spotlight:** The beam color and top-accent glow change to match the unique theme of each tab.
* **Custom Beam Geometry:** Uses a `CustomPainter` to create a realistic trapezoid light beam with theme-aware opacity for optimal contrast.
* **Centered Clustering:** Keeps icons grouped in the center of the bar for better thumb reach and a modern "Island" aesthetic.
* **Bottom-Docked:** Stays pinned to the bottom of the display regardless of screen resolution using native `bottomNavigationBar` alignment.



---

## 🚀 Quick Start

### 1. Install the component
```bash
pui-inject Spotlight Beam Footer
```

### 2. Implementation in main.dart
Use the following code to initialize the app. This configuration handles the automatic theme switching between Light and Dark modes:

```dart
import 'package:flutter/material.dart';
import 'spotlight_nav.dart'; // Ensure the path matches your file name

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Spotlight UI',
      
      // Light Theme Definition
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF5F5F7),
        useMaterial3: true,
      ),
      
      // Dark Theme Definition
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F0F0F),
        useMaterial3: true,
      ),
      
      // Automatically switches based on system settings
      themeMode: ThemeMode.system, 
      
      home: const Scaffold(
        body: Center(child: Text("Toggle System Theme to see the UI adapt")),
        bottomNavigationBar: SpotlightNav(),
      ),
    );
  }
}