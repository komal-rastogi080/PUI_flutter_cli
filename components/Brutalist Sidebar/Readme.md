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
import 'Brutalist Sidebar/sidebar.dart';
import 'Brutalist Sidebar/theme.dart';

void main() {
  runApp(const BrutalistApp());
}

class BrutalistApp extends StatefulWidget {
  const BrutalistApp({super.key});

  @override
  State<BrutalistApp> createState() => _BrutalistAppState();
}

class _BrutalistAppState extends State<BrutalistApp> {
  bool isDark = true;

  @override
  Widget build(BuildContext context) {
    final BrutalistTheme theme =
    isDark ? BrutalistTheme.day : BrutalistTheme.night;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 768;

          return Scaffold(
            backgroundColor: theme.background,

            /*──────── MOBILE: Drawer ────────*/
            drawer: isMobile
                ? Drawer(
              backgroundColor: Colors.transparent,
              child: BrutalistSidebar(
                theme: theme,
                onToggleTheme: () {
                  setState(() => isDark = !isDark);
                },
              ),
            )
                : null,

            /*──────── APP BAR (MOBILE ONLY) ────────*/
            appBar: isMobile
                ? AppBar(
              backgroundColor: theme.panel,
              elevation: 0,
              leading: Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.menu, color: theme.text),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            )
                : null,

            /*──────── BODY ────────*/
            body: Row(
              children: [
                /*──────── DESKTOP: Sidebar ────────*/
                if (!isMobile)
                  BrutalistSidebar(
                    theme: theme,
                    onToggleTheme: () {
                      setState(() => isDark = !isDark);
                    },
                  ),

                /*──────── MAIN CONTENT ────────*/
                Expanded(
                  child: Container(
                    color: theme.background,
                    alignment: Alignment.center,
                    child: Text(
                      "CONTENT AREA",
                      style: TextStyle(
                        color: theme.text,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
