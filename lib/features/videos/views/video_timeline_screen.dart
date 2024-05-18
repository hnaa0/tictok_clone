import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/view_models/timeline_vm.dart';
import 'package:tiktok_clone/features/videos/widgets/video_post.dart';

class VideoTimelineScreen extends ConsumerStatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  VideoTimelineScreenState createState() => VideoTimelineScreenState();
}

class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
  int _itemCount = 4;

  // PageController: PageView.builder를 컨트롤할 수 있게 해줌
  final PageController _pageController = PageController();

  final Duration _scrollDuration = const Duration(milliseconds: 200);
  final Curve _scrollCurve = Curves.linear;

  void _onPageChanged(int page) {
    _pageController.animateToPage(page,
        duration: _scrollDuration,
        curve: _scrollCurve); // curve: 보여주려는 애니메이션의 종류
    if (page == _itemCount - 1) {
      _itemCount = _itemCount + 4;

      setState(() {});
    }
  }

  void _onVideoFinished() {
    return;
    // _pageController.nextPage(
    //   duration: _scrollDuration,
    //   curve: _scrollCurve,
    // );
  }

  Future<void> _onRefresh() {
    return Future.delayed(const Duration(seconds: 5));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(timelineProvider).when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              "could not load videos: $error",
              style: const TextStyle(color: Colors.white),
            ),
          ),
          data: (videos) => RefreshIndicator(
            displacement: 50, // displacement: 화면을 당긴 다음 indicator의 위치
            edgeOffset: 20, // edgeOffset: indicator가 시작할 위치
            color: Theme.of(context).primaryColor,
            onRefresh: _onRefresh,
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical, // 스크롤 방향 지정
              onPageChanged:
                  _onPageChanged, // 유저가 이동할 때 도착하는 페이지에 대한 정보를 주는 메서드
              itemCount: videos.length,
              pageSnapping: true, // 스크롤 위치를 사용자지정으로 할 수 있음
              itemBuilder: (context, index) => VideoPost(
                index: index,
                onVideoFinished: _onVideoFinished,
              ),
            ),
          ),
        );
  }
}
