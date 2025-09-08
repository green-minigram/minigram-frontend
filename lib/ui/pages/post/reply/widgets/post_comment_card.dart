import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/post/reply/widgets/post_comment_item.dart';

class PostCommentCard extends StatefulWidget {
  final Map<String, dynamic> comment;
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
    required Map<String, dynamic> data,
    required bool isReply,
    required Widget child,
  }) {
    return Slidable(
      key: ValueKey(data["commentId"]),
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        extentRatio: 0.2,
        children: [
          SlidableAction(
            onPressed: (context) {
              print("삭제: ${data["commentId"]}");
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> replies = widget.comment["replies"] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 본댓글
        _buildSlidable(
          data: widget.comment,
          isReply: false,
          child: PostCommentItem(
            data: widget.comment,
            isReply: false,
            showReplies: _showReplies,
            onToggleReplies: () {
              setState(() {
                _showReplies = !_showReplies;
              });
            },
            onReplyTap: widget.onReplyTap,
          ),
        ),

        // 대댓글 리스트
        if (_showReplies && replies.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(left: MSize.kGap.l), // 들여쓰기
            child: Column(
              children: replies
                  .map(
                    (reply) => _buildSlidable(
                      data: reply,
                      isReply: true,
                      child: PostCommentItem(
                        data: reply,
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
