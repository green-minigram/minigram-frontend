import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/story/write/widget/story_write_body.dart';

class StoryWritePage extends StatelessWidget {
  final String videoPath;

  const StoryWritePage({super.key, required this.videoPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryWriteBody(videoPath: videoPath),
    );
  }
}
