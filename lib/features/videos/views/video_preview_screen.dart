import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/view_models/upload_video_vm.dart';
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

  late final TextEditingController _titleController = TextEditingController();
  late final TextEditingController _descController = TextEditingController();

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
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          showCloseIcon: true,
          content: Text(
            "The video title is required.",
          ),
        ),
      );
      return;
    }

    ref.read(uploadVideoProvider.notifier).uploadVideo(
          video: File(widget.video.path),
          title: _titleController.text,
          description: _descController.text,
          context: context,
        );
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
              onPressed: ref.watch(uploadVideoProvider).isLoading
                  ? null
                  : _onUploadPressed,
              icon: ref.watch(uploadVideoProvider).isLoading
                  ? const CircularProgressIndicator()
                  : const FaIcon(FontAwesomeIcons.cloudArrowUp),
            ),
          ],
        ),
        body: _videoPlayerController.value.isInitialized
            ? Stack(
                children: [
                  VideoPlayer(_videoPlayerController),
                  Positioned(
                      bottom: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.3,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "title",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Sizes.size16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextField(
                                controller: _titleController,
                                style: const TextStyle(
                                    fontSize: Sizes.size16,
                                    color: Colors.white),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                                onChanged: (value) {},
                              ),
                              Gaps.v12,
                              const Text(
                                "desc",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Sizes.size16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Gaps.v4,
                              TextField(
                                controller: _descController,
                                maxLines: 3,
                                maxLength: 200,
                                style: const TextStyle(
                                    fontSize: Sizes.size16,
                                    color: Colors.white),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: Sizes.size4,
                                    horizontal: Sizes.size6,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade600),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                      ))
                ],
              )
            : null);
  }
}
