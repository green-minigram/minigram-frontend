import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/data/model/post.dart';
import 'package:minigram/ui/pages/holder/home/home_vm.dart';
import 'package:minigram/ui/widgets/m_bottom_sheet.dart';
import 'package:minigram/ui/widgets/m_bottom_sheet_item.dart';
import 'package:minigram/ui/widgets/m_button.dart';
import 'package:minigram/ui/widgets/m_show_alert_dialog.dart';
import 'package:minigram/ui/widgets/m_story.dart';

class PostHeader extends ConsumerWidget {
  final bool showFollowButton;
  final bool isOwner;
  final Post post;

  PostHeader({
    super.key,
    this.showFollowButton = true,
    this.isOwner = false,
    required this.post,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    HomeVM vm = ref.read(homeProvider.notifier);
    // 팔로잉 여부만 선택적으로 구독하여 최신 상태를 그리게 함
    final isFollowing = ref.watch(
      homeProvider.select((m) {
        try {
          final posts = m?.postObject.postList ?? const [];
          final p = posts.firstWhere(
            (e) => e.user.userId == post.user.userId,
            orElse: () => post,
          );
          return p.user.isFollowing == true;
        } catch (_) {
          return post.user.isFollowing == true;
        }
      }),
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MSize.kGap.l),
      child: Row(
        children: [
          // 프로필 이미지 자리
          MStory(
            size: MSize.kStory.s,
            userId: post.user.userId, // TODO userId 필요
          ),
          SizedBox(width: MSize.kGap.s),

          // 아이디 + 이름 자리
          Expanded(
            child: Text(
              post.user.username,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MSize.kFont.normal,
              ),
            ),
          ),

          // 팔로우 버튼 (조건부 렌더링)
          if (showFollowButton)
            MButton(
              onPressed: () {
                print("팔로우 버튼 클릭됨");
                vm.toggleFollow(post.user.userId);
              },
              text: isFollowing ? "팔로잉" : "팔로우",
              textColor: MColor.kText.normal,
              borderRadius: MSize.kBorderRadius.s,
              backgroundColor: MColor.kButton.disabled,
              padding: EdgeInsets.symmetric(horizontal: MSize.kGap.l),
            ),

          // 더보기 버튼
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {
              MBottomSheet.show(
                context,
                items: post.isOwner
                    ? [
                        MSheetItem(
                          text: "수정",
                          icon: Icons.edit_outlined,
                          color: MColor.kText.normal,
                          onTap: () {
                            Navigator.pop(context);
                            print("수정 클릭됨");
                          },
                        ),
                        MSheetItem(
                          text: "삭제",
                          icon: Icons.delete_outline,
                          color: MColor.kIcon.red,
                          onTap: () {
                            Navigator.pop(context); // 먼저 BottomSheet 닫기
                            MShowAlertDialog.show(
                              context,
                              title: "게시물을 삭제하시겠어요?",
                              content: "삭제 선택 시 게시물이 영구적으로 삭제됩니다.",
                              failText: "취소",
                              successText: "삭제",
                              onFail: () {
                                print("삭제 취소됨");
                              },
                              onSuccess: () {
                                print("삭제 실행됨");
                                // 실제 삭제 로직 호출
                              },
                            );
                          },
                        ),
                      ]
                    : [
                        MSheetItem(
                          text: "팔로우 취소",
                          icon: Icons.person_remove_outlined,
                          color: MColor.kText.normal,
                          onTap: () {
                            Navigator.pop(context);
                            print("팔로우 취소 클릭됨");
                          },
                        ),
                        MSheetItem(
                          text: "신고",
                          icon: Icons.flag_outlined,
                          color: MColor.kIcon.red,
                          onTap: () {
                            Navigator.pop(context);
                            print("신고 클릭됨");
                          },
                        ),
                      ],
              );
            },
          ),
        ],
      ),
    );
  }
}
