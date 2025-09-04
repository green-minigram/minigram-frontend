import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/post/reply/widgets/post_reply_body.dart';

class PostReplyPage extends StatelessWidget {
  const PostReplyPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('게시글 댓글 상세 페이지 렌더링됨!'); // 렌더링 확인용
    return Scaffold(
      appBar: _appBar(context),
      body: PostReplyBody(),
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
