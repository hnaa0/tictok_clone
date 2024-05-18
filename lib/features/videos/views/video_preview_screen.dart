import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tiktok_clone/features/videos/view_models/timeline_vm.dart';
import 'package:video_player/video_player.dart';
import "package:path/path.dart" as p;

class VideoPreviewScreen extends ConsumerStatefulWidget {
  final XFile video;
  final bool isPicked;

  const VideoPreviewScreen({
    super.key,
    required this.video,
    required this.isPicked,
  });

  @override
  VideoPreviewScreenState createState() => VideoPreviewScreenState();
}

class VideoPreviewScreenState extends ConsumerState<VideoPreviewScreen> {
  late final VideoPlayerController _videoPlayerController;

  bool _savedVideo = false;

  Future<void> initVideo() async {
    _videoPlayerController =
        VideoPlayerController.file(File(widget.video.path));

    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();

    setState(() {});
  }

  Future<void> _saveGallery() async {
    if (_savedVideo) return;

    final Directory tempDir = await getTemporaryDirectory();
    final String newFileName =
        p.join(tempDir.path, "${DateTime.now().millisecondsSinceEpoch}.mp4");
    final File tempToMp4 = File(widget.video.path).renameSync(newFileName);

    await GallerySaver.saveVideo(
      tempToMp4.path,
      albumName: "Tiktok-clone",
    );
    _savedVideo = true;
    setState(() {});
  }

  void _onUploadPressed() {
    ref.read(timelineProvider.notifier).uploadVideo();
  }

  @override
  void initState() {
    super.initState();
    initVideo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Preview video"),
          actions: [
            if (!widget.isPicked)
              IconButton(
                onPressed: _saveGallery,
                icon: FaIcon(
                  _savedVideo
                      ? FontAwesomeIcons.check
                      : FontAwesomeIcons.download,
                ),
              ),
            IconButton(
              onPressed: ref.watch(timelineProvider).isLoading
                  ? null
                  : _onUploadPressed,
              icon: ref.watch(timelineProvider).isLoading
                  ? const CircularProgressIndicator()
                  : const FaIcon(FontAwesomeIcons.cloudArrowUp),
            ),
          ],
        ),
        body: _videoPlayerController.value.isInitialized
            ? VideoPlayer(_videoPlayerController)
            : null);
  }
}
