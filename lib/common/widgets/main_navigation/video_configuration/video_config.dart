import 'package:flutter/widgets.dart';

// interitedwidget은 앱 전체에 데이터를 공유하지만 업데이트는 불가
// => statefulwidget과 합친다면? 가능
// 데이터 관리, 관리를 위핫 셋팅: statefulwidget
// 데이터, 데이터 수정 방법 전달: inheritedwidget

class VideoConfigData extends InheritedWidget {
  final bool autoMute;
  final void Function() toggleMuted;

  const VideoConfigData({
    super.key,
    required this.autoMute,
    required super.child,
    required this.toggleMuted,
  });

  static VideoConfigData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VideoConfigData>()!;
  }

  // updateShouldNotify: 프레임워크가 이 위젯을 상속하는 위젯들에게 알릴지 결정.
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class VideoConfig extends StatefulWidget {
  final Widget child;
  const VideoConfig({
    super.key,
    required this.child,
  });

  @override
  State<VideoConfig> createState() => _VideoConfigState();
}

class _VideoConfigState extends State<VideoConfig> {
  bool autoMute = false;

  void _toggleMuted() {
    setState(() {
      autoMute = !autoMute;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VideoConfigData(
      autoMute: autoMute,
      toggleMuted: _toggleMuted,
      child: widget.child,
    );
  }
}
