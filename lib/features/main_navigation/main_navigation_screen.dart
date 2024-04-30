import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIdx = 0;

  final screens = [
    const Center(
      child: Text("Home"),
    ),
    const Center(
      child: Text("Search"),
    ),
    const Center(
      child: Text("Home"),
    ),
    const Center(
      child: Text("Home"),
    ),
    const Center(
      child: Text("Search"),
    ),
  ];

  void _onTap(int idx) {
    setState(() {
      _selectedIdx = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIdx],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType
            .shifting, // shifting으로 설정 시 items.length < 4여도 backgroundColor 활성화 됨.
        onTap: _onTap,
        currentIndex: _selectedIdx,
        // selectedItemColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.house),
            label: "Home",
            tooltip: "What are you?",
            backgroundColor: Colors.lightGreen
                .shade200, // backgroundColor: items.length > 3일 때 활성화 됨.
          ),
          BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
            label: "Searh",
            tooltip: "What are you?",
            backgroundColor: Colors.lime.shade200,
          ),
        ],
      ),
    );
  }
}
