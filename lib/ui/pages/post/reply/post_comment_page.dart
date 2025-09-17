import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/post/reply/widgets/post_comment_body.dart';

class PostCommentPage extends StatelessWidget {
  final int postId;

  const PostCommentPage({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: PostCommentBody(postId: postId), // postId 넘겨주기
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.arrow_back_ios),
    ),
    title: const Text('댓글'),
  );
}
