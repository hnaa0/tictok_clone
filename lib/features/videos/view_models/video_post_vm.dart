import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/videos/repos/videos_repo.dart';

// FamilyAsyncNotifier: notifier에 추가 인자를 보낼 수 있게 해줌
class VideoPostViewModel extends FamilyAsyncNotifier<void, String> {
  late final VideosRepository _repository;
  late final _videoId;
  late final _isLiked;

  Future<bool> get isLiked => _isLiked;

  @override
  FutureOr<void> build(String videoId) {
    _videoId = videoId;
    _repository = ref.read(videoRepo);
    final user = ref.read(authRepo).user;
    _isLiked = _repository.isLiked(userId: user!.uid, videoId: _videoId);
  }

  likeVideo() async {
    final user = ref.read(authRepo).user;
    await _repository.toggleLikeVideo(_videoId, user!.uid);
  }
}

final videoPostProvider =
    AsyncNotifierProvider.family<VideoPostViewModel, void, String>(
  () => VideoPostViewModel(),
);
