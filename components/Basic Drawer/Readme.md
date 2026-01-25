
# PUI Sidebar & Navigation Drawer Toolkit 🚀

A high-fidelity, interactive, and theme-aware navigation system for Flutter. This toolkit provides a seamless transition between desktop-first **Sidebars** and mobile-first **Drawers**, ensuring your application remains responsive across all device types.

---

## ✨ Features

* **Adaptive Navigation**: Includes a fixed `Sidebar` for desktop/web and a `SidebarDrawer` for mobile/tablet.
* **Animated Transitions**: Uses `AnimatedContainer` to transition smoothly between expanded (270px) and collapsed (85px) states.
* **Theme Synchronization**: Integrated support for toggling between Light and Dark modes with real-time UI updates.
* **Interactive Design**:
    * **Hover Effects**: Desktop-optimized background highlighting using `MouseRegion`.
    * **Motion UI**: Uses `AnimatedSwitcher` to transition between text labels and icons during state changes.
* **Modern Flutter Standards**: Leverages `ThemeData` and `colorScheme` for consistent styling across light and dark modes.

---

## 🚀 Getting Started

### 1. Requirements
* **Flutter SDK**: Any version supporting Flutter 3.x.
### 2. Inject the component
```bash
pui-inject Basic Drawer
```

### 2. Implementation
To use this toolkit, integrate it into your main `Scaffold`. You can use a `LayoutBuilder` to toggle between the Sidebar and the Drawer based on the screen width.



```dart
import 'package:flutter/material.dart';
import 'Basic Drawer/sidebar.dart';
import 'Basic Drawer/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Global state for Theme and Navigation
  bool _isDarkMode = true;
  int _selectedIndex = 0;
  bool _isExpanded = true;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PUI Sidebar Demo',
      // Apply Theme based on state
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        cardColor: const Color(0xFF121212),
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        // Implementation for Mobile: Shows the Drawer when screen is narrow
        drawer: SidebarDrawer(
          selectedIndex: _selectedIndex,
          isDarkMode: _isDarkMode,
          onThemeToggle: _toggleTheme,
          onItemSelected: (index) {
            setState(() => _selectedIndex = index);
          },
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            bool isMobile = constraints.maxWidth < 800;

            return Row(
              children: [
                // Implementation for Desktop: Shows the Sidebar
                if (!isMobile)
                  Sidebar(
                    isExpanded: _isExpanded,
                    isDarkMode: _isDarkMode,
                    selectedIndex: _selectedIndex,
                    onThemeToggle: _toggleTheme,
                    onItemSelected: (index) {
                      setState(() => _selectedIndex = index);
                    },
                  ),

                // Main Content Area
                Expanded(
                  child: Column(
                    children: [
                      _buildTopBar(isMobile),
                      Expanded(
                        child: _buildMainContent(),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // A simple AppBar-like widget to handle expansion toggle and mobile menu
  Widget _buildTopBar(bool isMobile) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor, width: 0.5)),
      ),
      child: Row(
        children: [
          if (isMobile)
            Builder(builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              );
            })
          else
            IconButton(
              icon: Icon(_isExpanded ? Icons.menu_open : Icons.menu),
              onPressed: () => setState(() => _isExpanded = !_isExpanded),
            ),
          const SizedBox(width: 12),
          Text(
            AppConstants.navItems[_selectedIndex].label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            AppConstants.navItems[_selectedIndex].icon,
            size: 100,
            color: Colors.deepPurple,
          ),
          const SizedBox(height: 20),
          Text(
            "Welcome to ${AppConstants.navItems[_selectedIndex].label}",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 10),
          const Text("Select different items to change state."),
        ],
      ),
    );
  }
}
