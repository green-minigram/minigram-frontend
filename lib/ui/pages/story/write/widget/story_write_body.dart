import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/story/write/widget/story_preview.dart';

class StoryWriteBody extends StatelessWidget {
  final String videoPath;

  const StoryWriteBody({
    super.key,
    required this.videoPath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StoryPreview(videoPath: videoPath),
      ],
    );
  }
}
