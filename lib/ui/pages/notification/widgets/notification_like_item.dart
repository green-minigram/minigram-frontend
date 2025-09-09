import 'package:flutter/material.dart';
import 'package:minigram/_core/util/m_date.dart';

class NotificationLikeItem extends StatelessWidget {
  final Map<String, dynamic> data;

  const NotificationLikeItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final user = data["user"];
    final post = data["post"];

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user["profileImageUrl"] ?? ""),
      ),
      title: Text("${user["username"]}님이 회원님의 게시글을 좋아합니다."),
      subtitle: Text(
        MDate.timeAgo(data["createdAt"] ?? ""),
      ),
      trailing: post != null
          ? Image.network(
              post["postImageUrl"] ?? "",
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            )
          : null,
      onTap: () {},
    );
  }
}
