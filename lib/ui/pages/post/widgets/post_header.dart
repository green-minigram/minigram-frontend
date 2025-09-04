import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/widgets/m_button.dart';

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
          CircleAvatar(
            radius: MSize.kBorderRadius.l,
            backgroundImage: NetworkImage(
              "https://i.namu.wiki/i/lbs5tIVXbGEvdR_3Co1azYeKBzKPNbo6GnxiHzndu1dCfSk7rob-Gs2wJZFmC4Oy7O_vq5hmzKzRd3i6WMl9_ul6pRENX1wAUU14fv1G_XFDwx8j1gY2gzugVVYZME2U2oJDqFoqREz3vuM1gcYaAQ.webp", // 프로필 이미지 URL
            ),
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
              showModalBottomSheet(
                context: context,
                backgroundColor: MColor.kBackGround.normal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(MSize.kBorderRadius.xl)),
                ),
                builder: (context) {
                  return SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 40,
                          height: 5,
                          margin: EdgeInsets.only(top: MSize.kGap.xs, bottom: MSize.kGap.m),
                          decoration: BoxDecoration(
                            color: MColor.kNormal.grey400,
                            borderRadius: BorderRadius.circular(MSize.kBorderRadius.xxs),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(MSize.kGap.m),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(MSize.kGap.m),
                          ),
                          child: Material(
                            borderRadius: BorderRadius.circular(MSize.kGap.m),
                            clipBehavior: Clip.hardEdge,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (isOwner) ...[
                                  ListTile(
                                    leading: Icon(Icons.edit),
                                    tileColor: MColor.kButton.disabled,
                                    title: Text("수정"),
                                    onTap: () {
                                      Navigator.pop(context);
                                      print("수정 클릭됨");
                                    },
                                  ),
                                  Divider(height: MSize.kLine.normal),
                                  ListTile(
                                    tileColor: MColor.kButton.disabled,
                                    leading: Icon(Icons.delete, color: MColor.kIcon.red),
                                    title: Text(
                                      "삭제",
                                      style: TextStyle(color: MColor.kText.red),
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                      print("삭제 클릭됨");
                                    },
                                  ),
                                ] else ...[
                                  ListTile(
                                    tileColor: MColor.kButton.disabled,
                                    leading: Icon(Icons.person_remove_outlined),
                                    title: Text("팔로우 취소"),
                                    onTap: () {
                                      Navigator.pop(context);
                                      print("팔로우 취소 클릭됨");
                                    },
                                  ),
                                  Divider(height: MSize.kLine.normal),
                                  ListTile(
                                    tileColor: MColor.kButton.disabled,
                                    leading: Icon(Icons.flag_outlined, color: MColor.kIcon.red),
                                    title: Text(
                                      "신고",
                                      style: TextStyle(color: MColor.kText.red),
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);
                                      print("신고 클릭됨");
                                    },
                                  ),
                                ],
                              ],
                            ),
                          ),
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
