import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/notification/widgets/notification_comment_item.dart';
import 'package:minigram/ui/pages/notification/widgets/notification_follow_item.dart';
import 'package:minigram/ui/pages/notification/widgets/notification_like_item.dart';

class NotificationBody extends StatelessWidget {
  final Map<String, dynamic> notifications;

  const NotificationBody({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    final data = notifications["notifications"];

    return ListView(
      children: [
        _buildSectionTitle("좋아요"),
        ...data["likes"].map<Widget>((n) => NotificationLikeItem(data: n)).toList(),

        _buildSectionTitle("댓글"),
        ...data["comments"].map<Widget>((n) => NotificationCommentItem(data: n)).toList(),

        _buildSectionTitle("팔로우"),
        ...data["follows"].map<Widget>((n) => NotificationFollowItem(data: n)).toList(),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MSize.kGap.l, // 16.0
        vertical: MSize.kGap.xs, // 8.0
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: MSize.kFont.l, // 18.0
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
