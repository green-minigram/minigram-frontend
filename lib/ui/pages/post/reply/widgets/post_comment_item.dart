import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/post/reply/post_comment_vm.dart';
import 'package:minigram/ui/pages/post/reply/widgets/post_comment_item_body.dart';
import 'package:minigram/ui/pages/post/reply/widgets/post_comment_item_header.dart';
import 'package:minigram/ui/pages/post/reply/widgets/post_comment_item_like.dart';
import 'package:minigram/ui/widgets/m_story.dart';

class PostCommentItem extends StatelessWidget {
  final PostComment comment;
  final bool isReply;
  final bool showReplies;
  final VoidCallback? onToggleReplies;
  final void Function(String username)? onReplyTap;

  const PostCommentItem({
    super.key,
    required this.comment,
    this.isReply = false,
    this.showReplies = false,
    this.onToggleReplies,
    this.onReplyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: isReply ? MSize.kGap.huge : 0,
        top: MSize.kGap.xs,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MStory(
            size: isReply ? MSize.kStory.s * 0.8 : MSize.kStory.s,
            imageUrl: comment.user.profileImageUrl,
            isGradient: false,
            userId: comment.user.userId,
          ),
          SizedBox(width: MSize.kGap.xs),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PostCommentItemHeader(
                  username: comment.user.username,
                  createdAt: comment.createdAt.toIso8601String(),
                  isPostAuthor: false, // TODO: 필요시 추가
                ),
                PostCommentItemBody(
                  content: comment.content,
                  isReply: isReply,
                  replies: comment.replies,
                  showReplies: showReplies,
                  onToggleReplies: onToggleReplies,
                  onReplyTap: () => onReplyTap?.call(comment.user.username),
                ),
              ],
            ),
          ),
          PostCommentItemLike(
            isLiked: comment.isLiked,
            likesCount: comment.likeCount,
            onLike: () => print("좋아요: ${comment.commentId}"),
          ),
        ],
      ),
    );
  }
}
