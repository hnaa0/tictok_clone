import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  int _itemCount = 4;

  // PageController: PageView.builder를 컨트롤할 수 있게 해줌
  final PageController _pageController = PageController();

  List<Color> colors = [
    Colors.blue,
    Colors.lime,
    Colors.green,
    Colors.deepOrange,
  ];

  void _onPageChanged(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 150),
        curve: Curves.linear); // curve: 보여주려는 애니메이션의 종류
    if (page == _itemCount - 1) {
      _itemCount = _itemCount + 4;
      colors.addAll(
        [
          Colors.amber,
          Colors.grey,
          Colors.cyan,
          Colors.brown,
        ],
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // PageView.builder: ListView.builder와 유사
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical, // 스크롤 방향 지정
      onPageChanged: _onPageChanged, // 유저가 이동할 때 도착하는 페이지에 대한 정보를 주는 메서드
      itemCount: _itemCount,
      pageSnapping: true, // 스크롤 위치를 사용자지정으로 할 수 있음
      itemBuilder: (context, index) => Container(
        color: colors[index],
        child: Center(
          child: Text(
            "Screen $index",
            style: const TextStyle(fontSize: 40),
          ),
        ),
      ),
    );
  }
}
