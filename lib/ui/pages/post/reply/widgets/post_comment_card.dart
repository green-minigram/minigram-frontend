import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/post/reply/post_comment_vm.dart';
import 'package:minigram/ui/pages/post/reply/widgets/post_comment_item.dart';

class PostCommentCard extends StatefulWidget {
  final PostComment comment;
  final void Function(String username)? onReplyTap;

  const PostCommentCard({
    super.key,
    required this.comment,
    this.onReplyTap,
  });

  @override
  State<PostCommentCard> createState() => _PostCommentCardState();
}

class _PostCommentCardState extends State<PostCommentCard> {
  bool _showReplies = false;

  Widget _buildSlidable({
    required PostComment comment,
    required bool isReply,
    required Widget child,
  }) {
    return Slidable(
      key: ValueKey(comment.commentId),
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        extentRatio: 0.2,
        children: [
          SlidableAction(
            onPressed: (context) {
              print("삭제: ${comment.commentId}");
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            padding: const EdgeInsets.only(left: 8),
          ),
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final replies = widget.comment.replies;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSlidable(
          comment: widget.comment,
          isReply: false,
          child: PostCommentItem(
            comment: widget.comment,
            isReply: false,
            showReplies: _showReplies,
            onToggleReplies: () {
              setState(() => _showReplies = !_showReplies);
            },
            onReplyTap: widget.onReplyTap,
          ),
        ),
        if (_showReplies && replies.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(left: MSize.kGap.l),
            child: Column(
              children: replies
                  .map(
                    (reply) => _buildSlidable(
                      comment: reply,
                      isReply: true,
                      child: PostCommentItem(
                        comment: reply,
                        isReply: true,
                        onReplyTap: widget.onReplyTap,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }
}
