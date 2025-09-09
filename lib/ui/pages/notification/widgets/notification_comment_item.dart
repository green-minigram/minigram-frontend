import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/_core/util/m_date.dart';
import 'package:minigram/ui/widgets/m_story.dart';

class NotificationCommentItem extends StatelessWidget {
  final Map<String, dynamic> data;

  const NotificationCommentItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final user = data["user"];
    final post = data["post"];

    return ListTile(
      // 프로필 → CircleAvatar 대신 MStory 사용
      leading: MStory(
        size: MSize.kStory.s, // 50.0
        imageUrl: user["profileImageUrl"],
        isGradient: false, // 알림창이니까 그라데이션 빼는 것도 깔끔
      ),

      // 메시지
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: user["username"],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: MColor.kText.normal,
                fontSize: MSize.kFont.normal,
              ),
            ),
            TextSpan(
              text: "님이 댓글을 남겼습니다: ",
              style: TextStyle(
                color: MColor.kText.normal,
                fontSize: MSize.kFont.normal,
              ),
            ),
            TextSpan(
              text: "\"${data["comment"]}\"",
              style: TextStyle(
                color: MColor.kText.secondary,
                fontSize: MSize.kFont.normal,
              ),
            ),
          ],
        ),
      ),

      // 알림 시간
      subtitle: Text(
        MDate.timeAgo(data["createdAt"] ?? ""),
        style: TextStyle(
          color: MColor.kText.secondary,
          fontSize: MSize.kFont.s,
        ),
      ),

      // 게시글 대표 이미지
      trailing: ClipRRect(
        borderRadius: BorderRadius.circular(MSize.kBorderRadius.xs),
        child: Image.network(
          post["postImageUrl"],
          width: 40,
          height: 40,
          fit: BoxFit.cover,
        ),
      ),
      onTap: () {},
    );
  }
}
