import 'package:flutter/material.dart';

// changenofifier 사용시 inheritedwidget+statefulewidget과는 달리 리스너 위젯만 rebuild됨.

class VideoConfig extends ChangeNotifier {
  bool autoMute = false;

  void toggleAutoMute() {
    autoMute = !autoMute;
    notifyListeners(); // 리스너들에게 알려줌
  }
}

final videoConfig = VideoConfig();
