import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/discover/discover_screen.dart';
import 'package:tiktok_clone/features/inbox/inbox_screen.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_clone/common/widgets/main_navigation/widgets/post_video_button.dart';
import 'package:tiktok_clone/features/users/user_profile_screen.dart';
import 'package:tiktok_clone/features/videos/video_recording_screen.dart';
import 'package:tiktok_clone/features/videos/video_timeline_screen.dart';
import 'package:tiktok_clone/utils.dart';

class MainNavigationScreen extends StatefulWidget {
  static const String routeName = "mainNavigation";

  final String tab;

  const MainNavigationScreen({super.key, required this.tab});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<String> _tabs = [
    "home",
    "discover",
    "xx",
    "inbox",
    "profile",
  ];

  late int _selectedIdx = _tabs.indexOf(widget.tab);
  bool _isTapDown = false;

  final screens = [
    const Center(
      child: Text("Home"),
    ),
    const Center(
      child: Text("Discover"),
    ),
    Container(),
    const Center(
      child: Text("Inbox"),
    ),
    const Center(
      child: Text("Profile"),
    ),
  ];

  void _onTap(int idx) {
    context.go("/${_tabs[idx]}");
    setState(() {
      _selectedIdx = idx;
    });
  }

  void _onPostVideoButtonTap() {
    context.pushNamed(VideoRecordingScreen.routeName);
  }

  void _onLongPressPostviedoButton() {
    setState(() {
      _isTapDown = true;
    });
  }

  void _onLongPressEndPostviedoButton() {
    setState(() {
      _isTapDown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:
          _selectedIdx == 0 || isDark ? Colors.black : Colors.white,
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIdx != 0,
            child: const VideoTimelineScreen(),
          ),
          Offstage(
            offstage: _selectedIdx != 1,
            child: const DiscoverScreen(),
          ),
          Offstage(
            offstage: _selectedIdx != 3,
            child: const InboxScreen(),
          ),
          Offstage(
            offstage: _selectedIdx != 4,
            child: const UserProfileScreen(username: "gnar", tab: ""),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: _selectedIdx == 0 || isDark ? Colors.black : Colors.white,
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
                selectedIcon: FontAwesomeIcons.houseChimney,
                isSelected: _selectedIdx == 0 ? true : false,
                onTap: () => _onTap(0),
                selectedIdx: _selectedIdx,
              ),
              NavTab(
                text: "Discover",
                icon: FontAwesomeIcons.compass,
                selectedIcon: FontAwesomeIcons.solidCompass,
                isSelected: _selectedIdx == 1 ? true : false,
                onTap: () => _onTap(1),
                selectedIdx: _selectedIdx,
              ),
              Gaps.h24,
              GestureDetector(
                onTap: _onPostVideoButtonTap,
                onLongPress: _onLongPressPostviedoButton,
                onLongPressCancel: _onLongPressEndPostviedoButton,
                onLongPressEnd: (details) {
                  _onLongPressEndPostviedoButton();
                },
                child: PostVideoButton(
                    isTapDown: _isTapDown, inverted: _selectedIdx != 0),
              ),
              Gaps.h24,
              NavTab(
                text: "Inbox",
                icon: FontAwesomeIcons.message,
                selectedIcon: FontAwesomeIcons.solidMessage,
                isSelected: _selectedIdx == 3 ? true : false,
                onTap: () => _onTap(3),
                selectedIdx: _selectedIdx,
              ),
              NavTab(
                text: "Profile",
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                isSelected: _selectedIdx == 4 ? true : false,
                onTap: () => _onTap(4),
                selectedIdx: _selectedIdx,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
