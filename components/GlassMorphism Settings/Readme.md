# Glassmorphic Settings Component 🧊

A high-fidelity, responsive settings UI for Flutter featuring **Glassmorphism** (frosted glass) effects and vibrant, colorful icon containers. This component adapts seamlessly between light and dark modes while maintaining a glossy, modern aesthetic.

## Run the command
```bash
pui inject GlassMorphism Settings
```

## Features
* **Frosted Glass Effect**: Implements `BackdropFilter` with high-sigma blur for a premium glass look.
* **Vibrant Icon Styling**: Uses colorful circular backgrounds for icons to match modern UI trends.
* **Responsive Theming**: Automatically flips text and divider colors based on the application's brightness state.
* **Modern Flutter Standards**: Fully compliant with Flutter 3.27+ using `.withValues()` for color precision.

## Implementation Guide (`main.dart`)

To use this component, lift the theme state to your `MainScaffold` and wrap the screen in a `MaterialApp` that supports both light and dark modes.

```dart
import 'package:flutter/material.dart';
import 'glass_settings.dart'; // Ensure the component code is in this file

void main() => runApp(const PUIApp());

class PUIApp extends StatefulWidget {
  const PUIApp({super.key});

  @override
  State<PUIApp> createState() => _PUIAppState();
}

class _PUIAppState extends State<PUIApp> {
  bool _isDark = true; // Default to Dark Mode for best glass visibility

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Define system themes
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: GlassSettingsScreen(
        isDark: _isDark,
        onThemeToggle: (bool val) {
          setState(() {
            _isDark = val;
          });
        },
      ),
    );
  }
}