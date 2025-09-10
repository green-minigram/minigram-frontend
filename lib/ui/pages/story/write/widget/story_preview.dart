import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/ui/pages/story/widgets/story_video_player.dart';

class StoryPreview extends StatelessWidget {
  final String videoPath;

  const StoryPreview({super.key, required this.videoPath});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Container(
        color: MColor.kNormal.black,
        child: Align(
          alignment: Alignment(0, -0.35),
          child: StoryVideoPlayer(videoPath: videoPath),
        ),
      ),
    );
  }
}
