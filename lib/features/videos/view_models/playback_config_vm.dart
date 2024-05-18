import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/playback_config_model.dart';
import 'package:tiktok_clone/features/videos/repos/video_playback_config_repo.dart';

class PlaybackConfigViewModel extends Notifier<PlaybackConfigModel> {
  final VideoPlaybackConfigRepository _repository;

  PlaybackConfigViewModel(this._repository);

  void setMuted(bool value) {
    _repository.setMuted(value);
    state = PlaybackConfigModel(autoplay: state.autoplay, muted: value);
  }

  void setAutoplay(bool value) {
    _repository.setAutoplay(value);
    state = PlaybackConfigModel(autoplay: value, muted: state.muted);
  }

  @override
  PlaybackConfigModel build() {
    // state의 초기 데이터 반환
    return PlaybackConfigModel(
      autoplay: _repository.isAutoplay(),
      muted: _repository.isMuted(),
    );
  }
}

// <1.expose할 provider 2.provider가 expose할 데이터>
final playbackConfigProvider =
    NotifierProvider<PlaybackConfigViewModel, PlaybackConfigModel>(
  () => throw UnimplementedError(),
);
