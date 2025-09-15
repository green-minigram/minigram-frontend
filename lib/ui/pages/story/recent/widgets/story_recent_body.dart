import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/_core/util/m_date.dart';
import 'package:minigram/ui/pages/story/recent/story_recent_vm.dart';
import 'package:minigram/ui/pages/story/write/widget/story_preview.dart';
import 'package:minigram/ui/widgets/m_bottom_sheet.dart';
import 'package:minigram/ui/widgets/m_bottom_sheet_item.dart';
import 'package:minigram/ui/widgets/m_button.dart';
import 'package:minigram/ui/widgets/m_show_alert_dialog.dart';

class StoryRecentBody extends ConsumerStatefulWidget {
  final int userId;

  const StoryRecentBody({
    super.key,
    required this.userId,
  });

  @override
  ConsumerState<StoryRecentBody> createState() => _StoryResentBodyState();
}

class _StoryResentBodyState extends ConsumerState<StoryRecentBody> {
  int currentIndex = 0; // 현재 스토리 인덱스

  void _goToNextStory(int length) {
    if (currentIndex < length - 1) {
      setState(() => currentIndex++);
    } else {
      Navigator.pop(context);
    }
  }

  void _goToPreviousStory() {
    if (currentIndex > 0) {
      setState(() => currentIndex--);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(storyRecentProvider(widget.userId));
    final vm = ref.read(storyRecentProvider(widget.userId).notifier);

    if (state == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final storyItem = state.storyList[currentIndex]; // 현재 스토리 선택
    final story = storyItem.story;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Stack(
        children: [
          // 배경 영상
          GestureDetector(
            onTapUp: (details) {
              final screenWidth = MediaQuery.of(context).size.width;
              if (details.localPosition.dx < screenWidth / 2) {
                _goToPreviousStory();
              } else {
                _goToNextStory(state.storyList.length);
              }
            },
            child: StoryPreview(
              videoPath: story.videoUrl,
            ),
          ),

          // 오버레이 UI
          Positioned(
            top: 60,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 인디케이터
                Row(
                  children: List.generate(
                    state.storyList.length.clamp(0, 5), // 인디케이터 수
                    (index) {
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: MSize.kGap.xxxxs,
                          ),
                          height: 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              MSize.kBorderRadius.xxs,
                            ),
                            color: index == currentIndex
                                ? MColor.kNormal.white
                                : MColor.kNormal.white.withValues(alpha: 0.3),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: MSize.kGap.s),

                // 프로필 + 아이디 + 버튼들
                Row(
                  children: [
                    CircleAvatar(
                      radius: MSize.kBorderRadius.l,
                      backgroundImage: NetworkImage(state.user.profileImageUrl!),
                    ),
                    SizedBox(width: MSize.kGap.xs),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.user.username,
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
                    Spacer(),

                    // 팔로우 버튼
                    if (!storyItem.isOwner)
                      MButton.outline(
                        text: storyItem.isFollowing ? "팔로잉" : "팔로우",
                        onPressed: () {
                          print("팔로우 클릭: ${state.user.userId}");
                          ref
                              .read(storyRecentProvider(widget.userId).notifier)
                              .toggleFollowDebounced(state.user.userId);
                        },
                        borderSide: storyItem.isFollowing ? BorderSide.none : BorderSide(color: MColor.kIcon.white),
                        textColor: MColor.kText.white,
                        backgroundColor: storyItem.isFollowing
                            ? Colors.black.withValues(alpha: 0.3)
                            : Colors.transparent,
                        padding: EdgeInsets.symmetric(
                          horizontal: MSize.kGap.m,
                          vertical: MSize.kGap.xs,
                        ),
                        textSize: MSize.kFont.s,
                        borderRadius: 9,
                      ),
                    SizedBox(width: MSize.kGap.xs),

                    // 좋아요 버튼
                    IconButton(
                      onPressed: () => {
                        print("좋아요 클릭: ${story.storyId}"),
                        ref.read(storyRecentProvider(widget.userId).notifier).toggleLike(story.storyId),
                        // storyId 활용 TODO 좋아요 통신 처리 해야함
                      },
                      icon: Icon(
                        storyItem.isLiked ? Icons.favorite : Icons.favorite_border,
                        color: storyItem.isLiked ? MColor.kIcon.red : MColor.kIcon.white,
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
                          items: storyItem.isOwner
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
                                        onFail: () => print("삭제 취소됨"),
                                        onSuccess: () async {
                                          print("삭제 실행됨: ${story.storyId}");
                                          await vm.deleteStory(story.storyId);

                                          if (vm.state == null && Navigator.canPop(context)) {
                                            Navigator.pop(context);
                                          }
                                        },
                                      );
                                    },
                                  ),
                                  MSheetItem(
                                    text: "취소",
                                    icon: Icons.close,
                                    color: MColor.kIcon.normal,
                                    onTap: () => Navigator.pop(context),
                                  ),
                                ]
                              : [
                                  MSheetItem(
                                    text: "신고",
                                    icon: Icons.flag_outlined,
                                    color: MColor.kIcon.red,
                                    onTap: () {
                                      Navigator.pop(context);
                                      print("신고 실행됨: ${story.storyId}");
                                      Navigator.pushNamed(
                                        context,
                                        "/abuse-report/reason",
                                        arguments: {
                                          "storyId": story.storyId,
                                          "userId": state.user.userId,
                                        },
                                      );
                                    },
                                  ),
                                  MSheetItem(
                                    text: "취소",
                                    icon: Icons.close,
                                    color: MColor.kIcon.normal,
                                    onTap: () => Navigator.pop(context),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
