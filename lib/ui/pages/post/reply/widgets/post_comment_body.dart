import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/post/reply/post_comment_vm.dart';
import 'package:minigram/ui/pages/post/reply/widgets/post_comment_card.dart';
import 'package:minigram/ui/pages/post/reply/widgets/post_comment_input_bar.dart';

class PostCommentBody extends ConsumerStatefulWidget {
  final int postId;

  const PostCommentBody({super.key, required this.postId});

  @override
  ConsumerState<PostCommentBody> createState() => _PostCommentBodyState();
}

class _PostCommentBodyState extends ConsumerState<PostCommentBody> {
  final FocusNode _replyFocusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  String? _replyToUser;

  void _focusReplyField(String username) {
    setState(() => _replyToUser = username);
    FocusScope.of(context).requestFocus(_replyFocusNode);
  }

  void _cancelReply() {
    setState(() => _replyToUser = null);
    _replyFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final commentModel = ref.watch(postCommentProvider(widget.postId));

    if (commentModel == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(MSize.kGap.m),
            itemCount: commentModel.comments.length,
            itemBuilder: (context, index) {
              final comment = commentModel.comments[index];
              return PostCommentCard(
                comment: comment,
                onReplyTap: _focusReplyField,
              );
            },
          ),
        ),
        Divider(height: MSize.kLine.normal),
        PostCommentInputBar(
          controller: _controller,
          focusNode: _replyFocusNode,
          replyToUser: _replyToUser,
          onCancelReply: _cancelReply,
          onSend: () {
            print("댓글 전송: ${_controller.text}");
            _controller.clear();
            _cancelReply();
          },
        ),
      ],
    );
  }
}
