import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/post/reply/widgets/post_comment_body.dart';

class PostCommentPage extends StatelessWidget {
  const PostCommentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: PostCommentBody(),
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(Icons.arrow_back_ios),
    ),
    title: Column(
      children: [
        Text('댓글'),
      ],
    ),
  );
}
