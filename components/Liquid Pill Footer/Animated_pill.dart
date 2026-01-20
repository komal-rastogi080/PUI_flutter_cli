import 'package:flutter/material.dart';

class DynamicColorPillNav extends StatefulWidget {
  const DynamicColorPillNav({super.key});

  @override
  State<DynamicColorPillNav> createState() => _DynamicColorPillNavState();
}

class _DynamicColorPillNavState extends State<DynamicColorPillNav> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Define unique colors for each tab as requested
  final List<Color> _pillColors = [
    const Color(0xFFB4F89F), // Home - Mint Green
    const Color(0xFF90CAF9), // Products - Blue
    const Color(0xFFFFCC80), // Blog - Orange
    const Color(0xFFF48FB1), // About - Pink
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    // Listener to update the UI when the pill moves
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: TabBarView(
        controller: _tabController,
        children: const [
          Center(child: Text("Home Content")),
          Center(child: Text("Products Content")),
          Center(child: Text("Blog Content")),
          Center(child: Text("About Content")),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          height: 64,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F7), // Neutral light grey bar
            borderRadius: BorderRadius.circular(32),
          ),
          child: TabBar(
            controller: _tabController,
            // When pressed, the content (text) becomes dark
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade600,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            indicatorSize: TabBarIndicatorSize.tab,
            // The moving pill changes color based on the selected index
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: _pillColors[_tabController.index],
            ),
            dividerColor: Colors.transparent,
            tabs: const [
              Tab(text: "Home"),
              Tab(text: "Products"),
              Tab(text: "Blog"),
              Tab(text: "About"),
            ],
          ),
        ),
      ),
    );
  }
}