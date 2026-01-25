# Sidebar (PUI)

A responsive sidebar component for Flutter apps.
Supports desktop sidebar and mobile drawer variants.

---

## Installation
```bash
pui-inject Modern Sleek Sidebar
```
## main.dart usage

```dart
import 'package:flutter/material.dart';
import 'Modern Sleek Sidebar/drawer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PUI Event Manager',
      // We handle the theme internally via your SidebarTheme logic,
      // but we set a base dark/light theme here for the scaffold.
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const MainShell(),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  bool _isDark = true;
  int _selectedIndex = 0;

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleTheme(bool value) {
    setState(() {
      _isDark = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isDesktop = constraints.maxWidth >= 900;

        return Scaffold(
          // 📱 On Mobile, we provide an AppBar to open the Drawer
          appBar: !isDesktop
              ? AppBar(
            title: const Text("PUI Dashboard"),
            backgroundColor: _isDark ? Colors.black : Colors.white,
            foregroundColor: _isDark ? Colors.white : Colors.black,
            elevation: 0,
          )
              : null,

          // 📱 Mobile Drawer logic
          drawer: !isDesktop
              ? ResponsiveSidebar(
            isDark: _isDark,
            onThemeToggle: _toggleTheme,
            selectedIndex: _selectedIndex,
            onItemTap: _onItemTap,
          )
              : null,

          body: Row(
            children: [
              // 🖥 Desktop Sidebar logic
              if (isDesktop)
                ResponsiveSidebar(
                  isDark: _isDark,
                  onThemeToggle: _toggleTheme,
                  selectedIndex: _selectedIndex,
                  onItemTap: _onItemTap,
                ),

              // 📄 Main Content Area
              Expanded(
                child: Container(
                  color: _isDark ? const Color(0xFF121212) : Colors.grey[100],
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          ResponsiveSidebar.items[_selectedIndex].icon,
                          size: 100,
                          color: _isDark ? Colors.white24 : Colors.black12,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Page: ${ResponsiveSidebar.items[_selectedIndex].label}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: _isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
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