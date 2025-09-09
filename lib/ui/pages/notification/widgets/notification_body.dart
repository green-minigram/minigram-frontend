import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/notification/widgets/notification_comment_item.dart';
import 'package:minigram/ui/pages/notification/widgets/notification_follow_item.dart';
import 'package:minigram/ui/pages/notification/widgets/notification_like_item.dart';

class NotificationBody extends StatelessWidget {
  final Map<String, dynamic> notifications;

  const NotificationBody({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    final data = notifications["notifications"];

    return Scaffold(
      appBar: AppBar(title: const Text("알림")),
      body: ListView(
        children: [
          _buildSectionTitle("좋아요"),
          ...data["likes"].map<Widget>((n) => NotificationLikeItem(data: n)).toList(),

          _buildSectionTitle("댓글"),
          ...data["comments"].map<Widget>((n) => NotificationCommentItem(data: n)).toList(),

          _buildSectionTitle("팔로우"),
          ...data["follows"].map<Widget>((n) => NotificationFollowItem(data: n)).toList(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}
