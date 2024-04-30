import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/main_navigation/main_navigation_screen.dart';

enum Direction { right, left }

enum Page { first, second }

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Direction _direction = Direction.right;
  Page _showingPage = Page.first;

  void _onEnterAppTap() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const MainNavigationScreen(),
        ),
        (route) => false);
  }

  void _onPanEnd(DragEndDetails details) {
    if (_direction == Direction.left) {
      setState(() {
        _showingPage = Page.first;
      });
    } else {
      _showingPage = Page.second;
    }
  }

  void _onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      // to the right
      setState(() {
        _direction = Direction.left;
      });
    } else {
      // to the left
      setState(() {
        _direction = Direction.right;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onPanUpdate: 사용자가 드래그할 때
      onPanUpdate: _onPanUpdate,
      // onPanEnd: 사용자가 드래그를 끝냈을 때
      onPanEnd: _onPanEnd,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size24,
          ),
          child: SafeArea(
            // AnimatedCrossFade: 두 컴포넌트 사이에 fade-in, fade-out 효과를 추가해주는 위젯
            child: AnimatedCrossFade(
              duration: const Duration(milliseconds: 300),
              crossFadeState: _showingPage == Page.first
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: const Page1(),
              secondChild: const Page2(),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size24,
              horizontal: Sizes.size24,
            ),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _showingPage == Page.first ? 0 : 1,
              child: CupertinoButton(
                onPressed: _showingPage == Page.first ? () {} : _onEnterAppTap,
                color: Theme.of(context).primaryColor,
                child: const Text(
                  "Enter the app",
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.v80,
        const Text(
          "Follow the rules",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Sizes.size44,
          ),
        ),
        Gaps.v16,
        Text(
          "Take care of one another!",
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: Sizes.size20,
          ),
        ),
      ],
    );
  }
}

class Page1 extends StatelessWidget {
  const Page1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.v80,
        const Text(
          "Watch cool videos!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Sizes.size44,
          ),
        ),
        Gaps.v16,
        Text(
          "Videos are personalized for you based on what you watch, like, and share.",
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: Sizes.size20,
          ),
        ),
      ],
    );
  }
}
