# 🎛️ Dynamic Neumorphic Bottom Navigation

A high-fidelity, Neumorphic "Soft UI" navigation bar for Flutter. This component features unique color themes for every tab, manual inset shadow effects (no packages required), and titles that animate into view only when selected.

## ✨ Features
* **Per-Tab Color Themes:** Each navigation item has its own distinct accent color.
* **Animated Titles:** Labels slide and fade into view dynamically upon selection.
* **Manual Inset Shadows:** Achieves a premium "pressed" look using standard Flutter `Stack` and `ClipRRect` techniques.
* **Bottom-Docked Layout:** Perfectly positioned and padded for modern mobile displays.

---

## 🛠️ Setup Guide

### 1. Install the component

```bash
pui-inject Neumorphic Footer Component
```

### 2. Implementation in main.dart
Replace the contents of your `main.dart` with the code below to initialize the navigation system.

```dart
import 'package:flutter/material.dart';
import 'package:your_project_name/neumorphic_nav.dart'; // Update with your actual project name

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Neumorphic UI',
      theme: ThemeData(
        brightness: Brightness.dark,
        // Using a deep dark background to make the soft shadows pop
        scaffoldBackgroundColor: const Color(0xFF0F1013),
        useMaterial3: true,
      ),
      home: const NeumorphicNav(),
    );
  }
}