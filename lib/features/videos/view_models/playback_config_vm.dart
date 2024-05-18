import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/videos/models/playback_config_model.dart';
import 'package:tiktok_clone/features/videos/repos/video_playback_config_repo.dart';

class PlaybackConfigViewModel extends ChangeNotifier {
  final VideoPlaybackConfigRepository _repository;

  late final PlaybackConfigModel _model = PlaybackConfigModel(
    autoplay: _repository.isAutoplay(),
    muted: _repository.isMuted(),
  );

  PlaybackConfigViewModel(this._repository);

  // repository, model를 직접 공개하지 않고 getter로 값 가져오기
  bool get muted => _model.muted;
  bool get autoplay => _model.autoplay;

  void setMuted(bool value) {
    // 1. repository에서 값을 디스크게 persist하게 저장
    // 2. model 수정
    // 3. 리스너들에게 notify

    _repository.setMuted(value);
    _model.muted = value;
    notifyListeners();
  }

  void setAutoplay(bool value) {
    // 1. repository에서 값을 디스크게 persist하게 저장
    // 2. model 수정
    // 3. 리스너들에게 notify

    _repository.setAutoplay(value);
    _model.autoplay = value;
    notifyListeners();
  }
}
