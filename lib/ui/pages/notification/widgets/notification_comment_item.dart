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
      leading: MStory(
        size: MSize.kStory.s,
        imageUrl: user["profileImageUrl"],
        isGradient: false,
        userId: 2, // TODO userId 필요
      ),
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
      subtitle: Text(
        MDate.timeAgo(data["createdAt"] ?? ""),
        style: TextStyle(
          color: MColor.kText.secondary,
          fontSize: MSize.kFont.s,
        ),
      ),
      trailing: ClipRRect(
        borderRadius: BorderRadius.circular(MSize.kBorderRadius.xs),
        child: Image.network(
          post["postImageUrl"],
          width: MSize.kIcon.l,
          height: MSize.kIcon.l,
          fit: BoxFit.cover,
        ),
      ),
      onTap: () {},
    );
  }
}
