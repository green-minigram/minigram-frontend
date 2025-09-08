import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';

class PostCommentItemBody extends StatelessWidget {
  final String content;
  final bool isReply;
  final List<dynamic> replies;
  final bool showReplies;
  final VoidCallback? onToggleReplies;
  final VoidCallback? onReplyTap;

  const PostCommentItemBody({
    super.key,
    required this.content,
    this.isReply = false,
    this.replies = const [],
    this.showReplies = false,
    this.onToggleReplies,
    this.onReplyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 본문
        Padding(
          padding: EdgeInsets.only(top: MSize.kGap.xxxs),
          child: Text(
            content,
            style: TextStyle(
              fontSize: MSize.kFont.normal,
              color: MColor.kText.normal,
            ),
          ),
        ),

        // 답글 달기
        Padding(
          padding: EdgeInsets.only(top: MSize.kGap.xxxs),
          child: InkWell(
            onTap: onReplyTap,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: MSize.kGap.xxxxs, horizontal: 4),
              child: Text(
                "답글 달기",
                style: TextStyle(
                  fontSize: MSize.kFont.s,
                  color: MColor.kText.secondary,
                ),
              ),
            ),
          ),
        ),

        // 댓글일 때만 "답글 N개 보기"
        if (!isReply && replies.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: MSize.kGap.xxxs),
            child: GestureDetector(
              onTap: onToggleReplies,
              child: Text(
                showReplies ? "답글 숨기기" : "답글 ${replies.length}개 더 보기",
                style: TextStyle(
                  fontSize: MSize.kFont.s,
                  fontWeight: FontWeight.w500,
                  color: MColor.kText.secondary,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
