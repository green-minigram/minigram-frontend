import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/story/widgets/story_video_player.dart';

class StoryPreview extends StatelessWidget {
  const StoryPreview({
    super.key,
    required this.videoPath,
  });

  final String videoPath;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          color: Colors.black,
          child: Stack(
            children: [
              // 영상 위쪽으로 살짝 올리기
              Align(
                alignment: const Alignment(0, -0.35), // y좌표 -0.2 정도 → 위로 이동
                child: StoryVideoPlayer(videoPath: videoPath),
              ),

              // 닫기 버튼
              SafeArea(
                child: Stack(
                  children: [
                    Positioned(
                      top: MSize.kGap.m,
                      left: MSize.kGap.xxs,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(MSize.kGap.s),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: MColor.kButton.grey.withValues(alpha: 0.8),
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: MSize.kIcon.s,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 40,
                right: 15,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_circle_right,
                    color: Colors.white,
                    size: 60,
                  ),
                  onPressed: () {
                    print("스토리 업로드 진행");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
