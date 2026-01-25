# BrutalistSidebar Component 🧱

A high-contrast, Brutalist-inspired responsive sidebar for Flutter. It features a technical "staircase" layout, dynamic theme switching, and a hover-to-expand interaction for desktop users.

## Features
* **Hover-to-Expand**: The sidebar stays at a minimal 72px width on desktop and expands to 280px when hovered.
* **Responsive Layout**: Automatically toggles between a persistent side-rail (Desktop) and a standard Scaffold Drawer (Mobile).
* **Theme-Synced**: Includes a global "DAY / NIGHT" toggle that updates the entire app's color palette.
* **Brutalist Aesthetic**: Hard-edged borders, thick lines, and bold typography.

## Getting Started

### 1. Inject the component
```bash
pui-inject Brutalist Sidebar
```

### 2. Full Implementation (`main.dart`)
Copy the following code into your `main.dart` to set up the state controller and responsive Row layout.

```dart
import 'package:flutter/material.dart';
import 'Brutalist Sidebar/theme.dart'; // Ensure your BrutalistTheme class is here
import 'Brutalist Sidebar/sidebar.dart';

void main() => runApp(const MaterialApp(home: MainScaffold()));

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  bool _isDark = true;
  int _currentIndex = 0;

  // Syncing themes based on the toggle state
  late BrutalistTheme _currentTheme;

  void _toggleTheme() {
    setState(() {
      _isDark = !_isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Dynamically select theme based on state
    _currentTheme = _isDark ? BrutalistTheme.night : BrutalistTheme.day;

    bool isDesktop = MediaQuery.of(context).size.width >= 768;

    return Scaffold(
      // The background now syncs with the sidebar theme
      backgroundColor: _currentTheme.panel == Colors.black ? Colors.black : Colors.white,

      drawer: isDesktop ? null : BrutalistSidebar(
        theme: _currentTheme,
        onToggleTheme: _toggleTheme,
      ),

      body: Row(
        children: [
          if (isDesktop)
            BrutalistSidebar(
              theme: _currentTheme,
              onToggleTheme: _toggleTheme,
            ),

          // Main Content Area synced with the sidebar's theme
          Expanded(
            child: Container(
              color: _isDark ? Colors.black : Colors.white,
              child: Center(
                child: Text(
                  "SYSTEM_BLOCK_0$_currentIndex",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: _isDark ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}