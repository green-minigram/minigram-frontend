import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/_core/util/m_date.dart';

class PostCommentItemHeader extends StatelessWidget {
  final String username;
  final String createdAt;
  final bool isPostAuthor;

  const PostCommentItemHeader({
    super.key,
    required this.username,
    required this.createdAt,
    required this.isPostAuthor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 닉네임
        Text(
          username,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: MSize.kFont.normal,
            color: MColor.kText.normal,
          ),
        ),
        SizedBox(width: MSize.kGap.xs),

        // 작성 시간
        Text(
          MDate.timeAgo(createdAt),
          style: TextStyle(
            fontSize: MSize.kFont.s,
            color: MColor.kText.secondary,
          ),
        ),

        // 작성자 태그
        if (isPostAuthor) ...[
          SizedBox(width: MSize.kGap.xxs),
          Text(
            "· 작성자",
            style: TextStyle(
              fontSize: MSize.kFont.s,
              fontWeight: FontWeight.w600,
              color: MColor.kText.description,
            ),
          ),
        ],
      ],
    );
  }
}
