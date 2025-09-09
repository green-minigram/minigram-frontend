import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/_core/util/m_date.dart';
import 'package:minigram/ui/widgets/m_story.dart';

class NotificationLikeItem extends StatelessWidget {
  final Map<String, dynamic> data;

  const NotificationLikeItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final user = data["user"];
    final post = data["post"];

    return ListTile(
      leading: MStory(
        size: MSize.kStory.s,
        imageUrl: user["profileImageUrl"] ?? "",
        isGradient: false,
      ),
      title: Text("${user["username"]}님이 회원님의 게시글을 좋아합니다."),
      subtitle: Text(
        MDate.timeAgo(data["createdAt"] ?? ""),
        style: TextStyle(fontSize: MSize.kFont.s),
      ),
      trailing: post != null
          ? Image.network(
              post["postImageUrl"] ?? "",
              width: MSize.kIcon.l,
              height: MSize.kIcon.l,
              fit: BoxFit.cover,
            )
          : null,
      onTap: () {},
    );
  }
}
