import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class StoryVideoPlayer extends StatefulWidget {
  final String videoPath;
  final bool autoPlay;
  final bool loop;

  const StoryVideoPlayer({
    super.key,
    required this.videoPath,
    this.autoPlay = true,
    this.loop = false,
  });

  @override
  State<StoryVideoPlayer> createState() => _StoryVideoPlayerState();
}

class _StoryVideoPlayerState extends State<StoryVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initController(widget.videoPath);
  }

  void _initController(String path) {
    if (path.startsWith("http")) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(path));
    } else if (File(path).existsSync()) {
      _controller = VideoPlayerController.file(File(path));
    } else {
      _controller = VideoPlayerController.asset(path);
    }

    _controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
      if (widget.autoPlay) _controller.play();
      _controller.setLooping(widget.loop);
    });
  }

  @override
  void didUpdateWidget(covariant StoryVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoPath != widget.videoPath) {
      _controller.dispose();
      _initController(widget.videoPath);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    );
  }
}
