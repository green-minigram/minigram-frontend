import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/data/gvm/session_gvm.dart';
import 'package:minigram/ui/pages/holder/profile/profile_vm.dart';
import 'package:minigram/ui/pages/story/write/widget/story_preview.dart';

class StoryWriteBody extends ConsumerWidget {
  final String videoPath;

  const StoryWriteBody({
    super.key,
    required this.videoPath,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 세션 감시
    final session = ref.watch(sessionProvider);

    // 프로필 감시 (userId 기반)
    final profile = ref.watch(
      profileProvider(session.user!.userId),
    );

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
                  onPressed: () async {
                    print("스토리 업로드 진행");
                    final session = ref.read(sessionProvider);
                    await ref.read(profileProvider(session.user!.userId).notifier).init(userId: session.user!.userId);
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
