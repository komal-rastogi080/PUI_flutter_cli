# 🔦 Universal Spotlight & Expanding Pill Navigation

A premium, high-fidelity navigation bar for Flutter. This component features a dynamic, multi-colored "Liquid Pill" that slides and expands to reveal tab titles. It is engineered to be fully responsive across **Mobile, Tablet, and Desktop** while supporting seamless **Light and Dark mode** transitions.

## ✨ Features

* **Adaptive Responsiveness:** Automatically adjusts bar width based on screen size using `LayoutBuilder`. Capped at `500px` on Desktop for UI elegance and `92%` width on Mobile for accessibility.
* **Weighted Expansion:** Uses a flex-weight system where the active tab expands to $2.5\times$ the width of inactive tabs, creating a smooth "liquid" transition.
* **Dual-Theme Support:** Real-time theme detection (`Theme.of(context).brightness`) switches the bar between deep charcoal and clean white.
* **Overflow Protection:** Integrated `Flexible` and `TextOverflow.ellipsis` logic prevents "RenderFlex" errors on small devices.
* **Dynamic Ambient Glow:** The bar's shadow color updates dynamically to match the active tab's unique color palette.
* **Elastic Physics:** Animated with `Curves.elasticOut` to provide a tactile, high-end feel during transitions.

---

## 🚀 Quick Start

### 1. Add the Component
```bash 
pui-inject Expanding Pill Footer
```

### 2. Implementation in main.dart
Configure your `MaterialApp` with both light and dark themes to enable the automatic theme-switching feature:

```dart
import 'package:flutter/material.dart';
import 'centered_pill_nav.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Light Theme
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF2F2F7),
        useMaterial3: true,
      ),
      // Dark Theme
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F0F0F),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system, // Switches based on system settings
      home: const Scaffold(
        body: Center(child: Text("Interactive Navigation UI")),
        bottomNavigationBar: CenteredPillNav(),
      ),
    );
  }
}