import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/widgets/m_bottom_sheet.dart';
import 'package:minigram/ui/widgets/m_bottom_sheet_item.dart';
import 'package:minigram/ui/widgets/m_button.dart';
import 'package:minigram/ui/widgets/m_story.dart';

class PostHeader extends StatelessWidget {
  final bool showFollowButton;
  bool isOwner;

  PostHeader({
    super.key,
    this.showFollowButton = true,
    this.isOwner = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MSize.kGap.l),
      child: Row(
        children: [
          // 프로필 이미지 자리
          MStory(
            size: MSize.kStory.s,
          ),
          SizedBox(width: MSize.kGap.s),

          // 아이디 + 이름 자리
          Expanded(
            child: Text(
              "아이디 자리",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: MSize.kFont.normal),
            ),
          ),

          // 팔로우 버튼 (조건부 렌더링)
          if (showFollowButton)
            MButton(
              onPressed: () {
                print("팔로우 버튼 클릭됨");
              },
              text: "팔로우",
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
                items: isOwner
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
                            Navigator.pop(context);
                            print("삭제 클릭됨");
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
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
