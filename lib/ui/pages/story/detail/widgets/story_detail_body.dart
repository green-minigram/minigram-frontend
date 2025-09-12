import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/_core/util/m_date.dart';
import 'package:minigram/ui/pages/story/detail/story_detail_vm.dart';
import 'package:minigram/ui/pages/story/write/widget/story_preview.dart';
import 'package:minigram/ui/widgets/m_bottom_sheet.dart';
import 'package:minigram/ui/widgets/m_bottom_sheet_item.dart';
import 'package:minigram/ui/widgets/m_button.dart';
import 'package:minigram/ui/widgets/m_show_alert_dialog.dart';

class StoryDetailBody extends ConsumerStatefulWidget {
  final int storyId;

  const StoryDetailBody({super.key, required this.storyId});

  @override
  ConsumerState<StoryDetailBody> createState() => _StoryDetailBodyState();
}

class _StoryDetailBodyState extends ConsumerState<StoryDetailBody> {
  bool isLiked = false; // 좋아요 로컬 상태
  bool isFollowing = false; // 팔로우 로컬 상태

  @override
  Widget build(BuildContext context) {
    final storyState = ref.watch(storyDetailProvider(widget.storyId));

    if (storyState == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // 최초 빌드 시 provider 값으로 초기화
    isLiked = storyState.isLiked;
    isFollowing = storyState.isFollowing;

    final user = storyState.user;
    final story = storyState.story;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Stack(
        children: [
          // 배경 영상
          StoryPreview(videoPath: story.videoUrl),

          // 오버레이 UI
          Positioned(
            top: 60,
            left: 16,
            right: 16,
            child: Row(
              children: [
                // 프로필 아바타
                InkWell(
                  onTap: () {},
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(user.imgUrl),
                  ),
                ),
                SizedBox(width: MSize.kGap.xs),

                // 아이디 + 시간
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.username,
                      style: TextStyle(
                        color: MColor.kText.white,
                        fontSize: MSize.kFont.m,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      MDate.timeAgo(story.createdAt),
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: MSize.kFont.s,
                      ),
                    ),
                  ],
                ),
                const Spacer(),

                // 팔로우 버튼 (isOwner == false일 때만 보임)
                if (!storyState.isOwner)
                  MButton.outline(
                    text: storyState.isFollowing ? "팔로잉" : "팔로우",
                    onPressed: () {
                      ref.read(storyDetailProvider(widget.storyId).notifier).toggleFollow(storyState.user.userId);
                    },
                    borderSide: storyState.isFollowing ? BorderSide.none : BorderSide(color: MColor.kIcon.white),
                    textColor: MColor.kText.white,
                    backgroundColor: storyState.isFollowing ? Colors.black.withValues(alpha: 0.3) : Colors.transparent,
                    padding: EdgeInsets.symmetric(
                      horizontal: MSize.kGap.m,
                      vertical: MSize.kGap.xs,
                    ),
                    textSize: MSize.kFont.s,
                    borderRadius: 9,
                  ),
                if (!storyState.isOwner) SizedBox(width: MSize.kGap.xs),

                // 좋아요 버튼 (UI 전용 토글)
                IconButton(
                  onPressed: () {
                    ref.read(storyDetailProvider(widget.storyId).notifier).toggleLike(storyState.story.storyId);
                  },
                  icon: Icon(
                    storyState.isLiked ? Icons.favorite : Icons.favorite_border,
                    color: storyState.isLiked ? MColor.kButton.like : MColor.kIcon.white,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: const CircleBorder(),
                    fixedSize: Size(MSize.kIcon.xxl, MSize.kIcon.xxl),
                  ),
                ),
                SizedBox(width: MSize.kGap.xs),

                // 메뉴 버튼
                IconButton(
                  onPressed: () {
                    MBottomSheet.show(
                      context,
                      items: storyState.isOwner
                          ? [
                              MSheetItem(
                                text: "삭제",
                                icon: Icons.delete_outline,
                                color: MColor.kIcon.red,
                                onTap: () {
                                  Navigator.pop(context);
                                  MShowAlertDialog.show(
                                    context,
                                    title: "스토리를 삭제하시겠어요?",
                                    content: "삭제 선택 시 스토리가 영구적으로 삭제됩니다.",
                                    failText: "취소",
                                    successText: "삭제",
                                    onFail: () {
                                      print("삭제 취소됨");
                                    },
                                    onSuccess: () {
                                      final vm = ref.read(storyDetailProvider(widget.storyId).notifier);
                                      vm.deleteStory(widget.storyId);
                                      // TODO 스토리 목록에서 지금 스토리 없애기 나중에 스토리 목록 만들고 나서 추가
                                      //  ref.read(storyListProvider.notifier).removeStory(widget.storyId);
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              ),
                              MSheetItem(
                                text: "취소",
                                icon: Icons.close,
                                color: MColor.kIcon.normal,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ]
                          : [
                              MSheetItem(
                                text: "신고",
                                icon: Icons.flag_outlined,
                                color: MColor.kIcon.red,
                                onTap: () {
                                  Navigator.pop(context);
                                  print("신고 클릭됨");
                                },
                              ),
                              MSheetItem(
                                text: "취소",
                                icon: Icons.close,
                                color: MColor.kIcon.normal,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                    );
                  },
                  icon: Icon(Icons.more_horiz, color: MColor.kIcon.white),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: const CircleBorder(),
                    fixedSize: Size(MSize.kIcon.xxl, MSize.kIcon.xxl),
                  ),
                ),
                SizedBox(width: MSize.kGap.xs),

                // 닫기 버튼
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, color: MColor.kIcon.white),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: const CircleBorder(),
                    fixedSize: Size(MSize.kIcon.xxl, MSize.kIcon.xxl),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
