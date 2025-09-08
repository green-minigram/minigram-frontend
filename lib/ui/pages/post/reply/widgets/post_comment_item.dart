import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/post/reply/widgets/post_comment_header.dart';
import 'package:minigram/ui/pages/post/reply/widgets/post_comment_item_body.dart';
import 'package:minigram/ui/pages/post/reply/widgets/post_comment_item_like.dart';
import 'package:minigram/ui/widgets/m_story.dart';

class PostCommentItem extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool isReply;
  final bool showReplies;
  final VoidCallback? onToggleReplies;
  final void Function(String username)? onReplyTap;

  const PostCommentItem({
    super.key,
    required this.data,
    this.isReply = false,
    this.showReplies = false,
    this.onToggleReplies,
    this.onReplyTap,
  });

  @override
  Widget build(BuildContext context) {
    final author = data["author"];
    final List<dynamic> replies = data["replies"] ?? [];

    return Padding(
      padding: EdgeInsets.only(
        left: isReply ? MSize.kGap.huge : 0,
        top: MSize.kGap.xs,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 프로필 이미지
          MStory(
            size: isReply ? MSize.kStory.s * 0.8 : MSize.kStory.s,
            imageUrl: author["profileImageUrl"],
            isGradient: false,
          ),
          SizedBox(width: MSize.kGap.xs),

          // Header + Body
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 닉네임 + 작성시간 + 작성자 표시
                PostCommentItemHeader(
                  username: author["username"],
                  createdAt: data["createdAt"],
                  isPostAuthor: author["isPostAuthor"] ?? false,
                ),

                // 본문 + 답글달기 + 답글 n개 토글
                PostCommentItemBody(
                  content: data["content"],
                  isReply: isReply,
                  replies: replies,
                  showReplies: showReplies,
                  onToggleReplies: onToggleReplies,
                  onReplyTap: () => onReplyTap?.call(author["username"]),
                ),
              ],
            ),
          ),

          // 좋아요 버튼
          PostCommentItemLike(
            isLiked: data["isLiked"] ?? false,
            likesCount: data["likesCount"] ?? 0,
            onLike: () => print("좋아요: ${data["commentId"]}"),
          ),
        ],
      ),
    );
  }
}
