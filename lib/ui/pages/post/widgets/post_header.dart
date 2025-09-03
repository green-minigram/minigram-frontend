import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/widgets/m_button.dart';

class PostHeader extends StatelessWidget {
  PostHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          // 프로필 이미지 자리
          CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(
              "https://i.namu.wiki/i/lbs5tIVXbGEvdR_3Co1azYeKBzKPNbo6GnxiHzndu1dCfSk7rob-Gs2wJZFmC4Oy7O_vq5hmzKzRd3i6WMl9_ul6pRENX1wAUU14fv1G_XFDwx8j1gY2gzugVVYZME2U2oJDqFoqREz3vuM1gcYaAQ.webp", // 프로필 이미지 URL
            ),
          ),
          SizedBox(width: 10),

          // 아이디 + 이름 자리
          Expanded(
            child: Text(
              "아이디 자리",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: MSizes.kFont.normal),
            ),
          ),

          MButton.outline(
            onPressed: () {
              print("팔로우 버튼 클릭됨");
            },
            child: const Text(
              "팔로우",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            borderSide: BorderSide.none,
            textColor: MColor.kText.normal,
            borderRadius: 9,
            backgroundColor: MColor.kButton.disabled,
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),

          // 더보기 버튼
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) {
                  return SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: Icon(Icons.person_remove_outlined),
                          title: Text("팔로우 취소"),
                          onTap: () {
                            Navigator.pop(context);
                            print("팔로우 취소 클릭됨");
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.flag_outlined, color: MColor.kText.red),
                          title: Text(
                            "신고",
                            style: TextStyle(color: Colors.red),
                          ),
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
