# Sidebar Component Usage Guide

To use this sidebar as a reusable component in your project, follow this setup in your `main.dart`.

After runnning the command
```bash
 pui-inject Morphing Sidebar"
```
### Integration Logic (`main.dart`)

This setup uses a `LayoutBuilder` to toggle between the **Mobile Drawer** (with the curved design) and the **Desktop Sidebar** (with the sharp edge).

```dart
import 'package:flutter/material.dart';
import 'theme.dart';
import 'custom_sidebar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: SidebarTheme.darkTheme,
      home: const MainScaffold(),
    );
  }
}

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
        // Switch to Desktop mode if screen width is 
        //900px
        bool isDesktop = constraints.maxWidth > 900;

        return Scaffold(
          appBar: isDesktop ? null : AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Builder(builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            )),
          ),

          drawer: isDesktop ? null : CustomSidebar(
            isMobile: true,
            selectedIndex: _currentIndex,
            onLogout: () => print("Logout Clicked"),
            onTabChange: (index) {
              setState(() => _currentIndex = index);
              Navigator.pop(context); // Close drawer smoothly
            },
          ),

          body: Row(
            children: [
              if (isDesktop)
                CustomSidebar(
                  isMobile: false,
                  selectedIndex: _currentIndex,
                  onLogout: () => print("Logout Clicked"),
                  onTabChange: (index) => setState(() => _currentIndex = index),
                ),
              
              // Main Content Display with Smooth Transitions
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    key: ValueKey<int>(_currentIndex),
                    child: Center(
                      child: Text(
                        "ACTIVE SECTION: $_currentIndex",
                        style: const TextStyle(fontSize: 24, color: Colors.white24),
                      ),
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