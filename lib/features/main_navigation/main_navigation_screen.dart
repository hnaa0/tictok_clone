import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/nav_tab.dart';

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
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(
            Sizes.size12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                  text: "Home",
                  icon: FontAwesomeIcons.house,
                  isSelected: _selectedIdx == 0 ? true : false,
                  onTap: () => _onTap(0)),
              NavTab(
                  text: "Discover",
                  icon: FontAwesomeIcons.magnifyingGlass,
                  isSelected: _selectedIdx == 1 ? true : false,
                  onTap: () => _onTap(1)),
              NavTab(
                  text: "Inbox",
                  icon: FontAwesomeIcons.message,
                  isSelected: _selectedIdx == 3 ? true : false,
                  onTap: () => _onTap(3)),
              NavTab(
                  text: "Home",
                  icon: FontAwesomeIcons.user,
                  isSelected: _selectedIdx == 4 ? true : false,
                  onTap: () => _onTap(4)),
            ],
          ),
        ),
      ),
    );
  }
}
