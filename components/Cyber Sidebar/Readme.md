# CyberSidebar Component ⚡

A technical, high-fidelity sidebar designed for Flutter applications. It features a responsive layout that adapts between a mobile drawer and a persistent desktop rail, complete with secondary status labels and neon accents.

## Features
* **Adaptive Navigation**: Automatically toggles between a persistent side-rail (Desktop) and a standard Scaffold Drawer (Mobile).
* **Context-Safe Logic**: Uses a `Builder` pattern to prevent common `Scaffold.of()` errors during navigation.
* **State-Synced**: Syncs navigation nodes across both views using a lifted state in the `MainScaffold`.
* **Modern Flutter Standards**: Implements `.withValues()` for color management, satisfying Flutter 3.27+ requirements.

## Implementation Guide (`main.dart`)
```bash
pui inject Cyber Sidebar
```

## main.dart usage

The following code demonstrates how to integrate the `CyberSidebar` as a responsive component while managing navigation state and theme-safe colors.

```dart
import 'package:flutter/material.dart';
import 'theme.dart'; // Ensure CyberTheme is defined here
import 'cyber_sidebar.dart';

void main() => runApp(const MaterialApp(
  debugShowCheckedModeBanner: false, 
  home: MainScaffold()
));

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Breakpoint for Desktop vs Mobile layout
        bool isDesktop = constraints.maxWidth >= 900;

        return Scaffold(
          // Mobile Drawer logic with Builder to provide proper context
          drawer: isDesktop ? null : Builder(
            builder: (innerContext) => CyberSidebar(
              isMobile: true,
              selectedIndex: _currentIndex,
              onTabChange: (int index) {
                setState(() => _currentIndex = index);
                Navigator.pop(innerContext); // Safely close the drawer
              },
              onLogout: () => print("Logout Sequence Initiated"),
            ),
          ),
          
          appBar: isDesktop ? null : AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text("PUI TERMINAL", style: TextStyle(fontSize: 14)),
          ),

          body: Row(
            children: [
              // Permanent Sidebar for Desktop View
              if (isDesktop)
                CyberSidebar(
                  isMobile: false,
                  selectedIndex: _currentIndex,
                  onTabChange: (int index) => setState(() => _currentIndex = index),
                  onLogout: () => print("Logout Sequence Initiated"),
                ),
              
              // Central content area
              Expanded(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.2),
                  child: Center(
                    child: Text(
                      "SYSTEM_NODE_0$_currentIndex",
                      style: const TextStyle(fontSize: 24, letterSpacing: 4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}