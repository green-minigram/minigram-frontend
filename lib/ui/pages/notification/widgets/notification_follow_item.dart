import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/_core/util/m_date.dart';
import 'package:minigram/ui/widgets/m_button.dart';
import 'package:minigram/ui/widgets/m_story.dart';

class NotificationFollowItem extends StatelessWidget {
  final Map<String, dynamic> data;

  const NotificationFollowItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final user = data["user"];

    return ListTile(
      leading: MStory(
        size: MSize.kStory.s,
        imageUrl: user["profileImageUrl"] ?? "",
        isGradient: false,
      ),
      title: Text("${user["username"]}님이 회원님을 팔로우하기 시작했습니다."),
      subtitle: Text(
        MDate.timeAgo(data["createdAt"] ?? ""),
      ),
      trailing: MButton(
        onPressed: () {
          print("팔로우 버튼 클릭됨");
        },
        text: user["isFollowing"] == true ? "팔로잉" : "팔로우",
        backgroundColor: user["isFollowing"] == true ? MColor.kButton.disabled : MColor.kButton.primary,
        textColor: user["isFollowing"] == true ? MColor.kText.normal : MColor.kNormal.white,
        borderRadius: MSize.kBorderRadius.s,
        padding: EdgeInsets.symmetric(
          horizontal: MSize.kGap.m,
          vertical: MSize.kGap.xs,
        ),
      ),
      onTap: () {},
    );
  }
}
