import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_clone/features/videos/widgets/video_button.dart';
import 'package:tiktok_clone/features/videos/widgets/video_comments.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

// SingleTickerProviderStateMixin: current tree가 활성화된 동안만(= 위젯이 화면에 보일 때만) tick하는 단일 ticker 제공
// ticker?: 일종의 시계. 애니메이션의 프레임마다 callback 실행.
// vsync?: offscreen 애니메이션의 불필요한 리소스 사용을 막음 = 위젯이 위젯 tree에 있을 때만 ticker 유지하게 해줌.(= 위젯이 안 보일 땐 애니메이션 정지)

// 애니메이션이 ticker 겟 -> 애니메이션이 재생될 때 ticker가 매 프레임마다 애니메이션에게 알려줌.

class VideoPost extends ConsumerStatefulWidget {
  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.videoData,
    required this.index,
  });

  final Function onVideoFinished;
  final VideoModel videoData;
  final int index;

  @override
  VideoPostState createState() => VideoPostState();
}

class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  late final VideoPlayerController _videoPlayerController;

  late final AnimationController _animationController;

  late bool _isPaused;
  bool _isMoreShowed = false;
  late bool _isMuted;

  final Duration _animationDuration = const Duration(milliseconds: 300);

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    _videoPlayerController =
        VideoPlayerController.network(widget.videoData.fileUrl);
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    if (kIsWeb) {
      await _videoPlayerController.setVolume(0);
    }
    setState(() {
      _videoPlayerController.addListener(_onVideoChange);
    });
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    _animationController = AnimationController(
      vsync: this, // this= 지금 이 클래스(+ ticker를 포함한 SingleTicker이기도 한)
      value: 1.5,
      lowerBound: 1.0,
      upperBound: 1.5,
      duration: _animationDuration,
    );

    _isMuted = ref.read(playbackConfigProvider).muted;
    _videoPlayerController.setVolume(_isMuted ? 0 : 1);
    _isPaused = !ref.read(playbackConfigProvider).autoplay;
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  // void _onPlaybackConfigChanged() {
  //   if (!mounted) return;
  //   final muted = ref.read(playbackConfigProvider).muted;
  //   if (muted) {
  //     _videoPlayerController.setVolume(0);
  //   } else {
  //     _videoPlayerController.setVolume(1);
  //   }
  // }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      if (ref.read(playbackConfigProvider).autoplay) {
        _videoPlayerController.play();
      }
    }

    // 다른 탭으로 넘어갔을 때 동영상 정지
    if (_videoPlayerController.value.isPlaying && info.visibleFraction < 1) {
      _onTogglePause();
    }
  }

  void _onTogglePause() {
    // 이미 dispose된 controller에 접근하지 않도록 mount되지 않았다면 리턴
    if (!mounted) return;
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }

    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onTapSeeMore() {
    setState(() {
      _isMoreShowed = true;
    });
  }

  void _onTapSeeLess() {
    if (_isMoreShowed) {
      setState(() {
        _isMoreShowed = false;
      });
    }
  }

  void _onCommentsTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const VideoComments(),
    ); // 유저가 bottom sheet 해제 시 resolve됨.
    _onTogglePause();
  }

  void _onUnmuteTapForWeb() {
    _videoPlayerController.setVolume(0.5);
    setState(() {});
  }

  void _onToggleMuted() {
    if (_isMuted) {
      _videoPlayerController.setVolume(1);
    } else {
      _videoPlayerController.setVolume(0);
    }

    setState(() {
      _isMuted = !_isMuted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                // : Image.network(
                //     widget.videoData.thumbnailUrl,
                //     fit: BoxFit.cover,
                //   ),
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                // AnimatedBuilder: controller를 감지하고 값이 변하면 builder 실행
                // -> 값이 변할 때마다 Transform.scale 리턴
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child, // 밑의 child(AnimatedOpacity)를 넘겨주기 위해
                    );
                  },
                  child: AnimatedOpacity(
                    duration: _animationDuration,
                    opacity: _isPaused ? 1 : 0,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 10,
            child: IconButton(
              icon: FaIcon(
                _isMuted
                    ? FontAwesomeIcons.volumeOff
                    : FontAwesomeIcons.volumeHigh,
                color: Colors.white,
              ),
              onPressed: _onToggleMuted,
            ),
          ),
          Positioned(
            bottom: 20,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "@${widget.videoData.creator}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v10,
                Row(
                  children: [
                    SizedBox(
                      width: _isMoreShowed ? 300 : 200,
                      child: GestureDetector(
                        onTap: _onTapSeeLess,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 100),
                          opacity: 1,
                          child: Text(
                            widget.videoData.description,
                            overflow: _isMoreShowed
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: Sizes.size16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Gaps.h4,
                    GestureDetector(
                      onTap: _onTapSeeMore,
                      child: AnimatedOpacity(
                        duration: const Duration(seconds: 0),
                        opacity: _isMoreShowed ? 0 : 1,
                        child: widget.videoData.description == ""
                            ? null
                            : const Text(
                                "See more",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Sizes.size16,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 25,
                  foregroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/tiktokclone-lec-nc.appspot.com/o/avatar%2F${widget.videoData.creatorUid}?alt=media"),
                  child: Text(widget.videoData.creator),
                ),
                Gaps.v24,
                VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: S.of(context).likeCount(widget.videoData.liked),
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: () => _onCommentsTap(context),
                  child: VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: S.of(context).commentCount(widget.videoData.comments),
                  ),
                ),
                Gaps.v24,
                const VideoButton(
                  icon: FontAwesomeIcons.share,
                  text: "Share",
                ),
              ],
            ),
          ),
          if (kIsWeb && _videoPlayerController.value.volume == 0.0)
            Positioned(
              top: Sizes.size18,
              right: Sizes.size18,
              child: GestureDetector(
                onTap: _onUnmuteTapForWeb,
                child: const FaIcon(
                  FontAwesomeIcons.volumeXmark,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
