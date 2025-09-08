import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/story/widgets/story_video_player.dart';

class StoryWriteBody extends StatelessWidget {
  const StoryWriteBody({
    super.key,
    required this.videoPath,
  });

  final String videoPath;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(child: StoryVideoPlayer(videoPath: videoPath)), // 공통 사용
        Positioned(
          top: 40,
          left: 16,
          child: IconButton(
            icon: Icon(Icons.close, color: Colors.red, size: 30),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        Positioned(
          bottom: 40,
          right: 16,
          child: FloatingActionButton(
            onPressed: () => print("스토리 업로드 진행"),
            child: const Icon(Icons.arrow_forward),
          ),
        ),
      ],
    );
  }
}
