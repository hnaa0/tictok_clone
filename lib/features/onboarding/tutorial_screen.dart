import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  @override
  Widget build(BuildContext context) {
    // DefaultTabController: 스와이프할 수 있게 만들어주는 위젯.
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: SafeArea(
          // TabBarView: 스와이프할 페이지를 담는 위젯.
          child: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v52,
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v52,
                    const Text(
                      "Follow the rules!",
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v52,
                    const Text(
                      "Enjoy the ride",
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
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size48,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // TabPageSelector: 스와이프 페이지들의 네비게이션 제공
                TabPageSelector(
                  selectedColor:
                      Theme.of(context).primaryColor.withOpacity(0.9),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
