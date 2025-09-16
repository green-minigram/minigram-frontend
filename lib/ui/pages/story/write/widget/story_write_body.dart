import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
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
        Expanded(
          child: Stack(
            children: [
              // 프리뷰
              StoryPreview(videoPath: videoPath),

              // 닫기 버튼
              Positioned(
                top: MSize.kGap.m,
                left: MSize.kGap.xxs,
                child: SafeArea(
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
              ),

              // 업로드 버튼
              Positioned(
                bottom: 40,
                right: 15,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_circle_right,
                    color: Colors.white,
                    size: MSize.kIcon.xxxl,
                  ),
                  onPressed: () {
                    print("스토리 업로드 진행");
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
