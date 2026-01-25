# Modern Settings Component ⚙️

A reusable, responsive settings screen for Flutter that supports dynamic Day/Night theme switching. It features grouped configuration tiles, a professional profile header, and high-fidelity icons that adapt their color based on the current theme brightness.

## Run the command
```bash
pui inject Minimalist Settings
```

## Features
* **Adaptive Icon Colors**: Icons automatically flip to white in Dark Mode and dark grey in Light Mode for maximum legibility.
* **Card-Based UI**: Uses a grouped "section" design with subtle shadows to create a modern, layered aesthetic.
* **Interactive Toggles**: Includes a built-in Dark Mode switch that triggers a global state change.
* **Clean Logic**: Implements `.withValues()` for shadow management, ensuring compatibility with Flutter 3.27+.

## Getting Started

### 1. Integration Example (`main.dart`)
Inject the `SettingsScreen` into your app and pass the theme state through the provided callbacks.

```dart
import 'package:flutter/material.dart';
import 'settings_screen.dart'; 

void main() => runApp(const SettingsApp());

class SettingsApp extends StatefulWidget {
  const SettingsApp({super.key});

  @override
  State<SettingsApp> createState() => _SettingsAppState();
}

class _SettingsAppState extends State<SettingsApp> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Define Light Theme
      theme: ThemeData(
        brightness: Brightness.light,
        iconTheme: const IconThemeData(color: Colors.black54),
        scaffoldBackgroundColor: const Color(0xFFF7F7F7),
        cardColor: Colors.white,
      ),
      // Define Dark Theme
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        iconTheme: const IconThemeData(color: Colors.white),
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardColor: const Color(0xFF1E1E1E),
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: SettingsScreen(
        isDarkMode: _isDarkMode,
        onThemeChanged: (value) => setState(() => _isDarkMode = value),
      ),
    );
  }
}