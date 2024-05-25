import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/users/view_models/users_vm.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/repos/videos_repo.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideosRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(videoRepo);
  }

  Future<void> uploadVideo({
    required BuildContext context,
    required File video,
    required String title,
    String? description,
  }) async {
    final user = ref.read(authRepo).user;
    final userProfile = ref.read(userProvider).value;
    if (userProfile != null) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(
        () async {
          final task = await _repository.uploadVideoFile(
            video,
            user!.uid,
          );
          if (task.metadata != null) {
            await _repository.saveVideo(
              VideoModel(
                id: "",
                title: title,
                description: description ?? "",
                fileUrl: await task.ref.getDownloadURL(),
                thumbnailUrl: "", // cloud function이 썸네일 url 제공하므로 비워두기
                creatorUid: user.uid,
                creator: userProfile.name,
                liked: 0,
                comments: 0,
                createdAt: DateTime.now().millisecondsSinceEpoch,
              ),
            );

            context.pushReplacement("/home");
          }
        },
      );
    }
  }
}

final uploadVideoProvider = AsyncNotifierProvider<UploadVideoViewModel, void>(
  () => UploadVideoViewModel(),
);
