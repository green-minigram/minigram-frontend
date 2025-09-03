import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/post/detail/widgets/post_detail_body.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('게시글 상세 페이지 렌더링됨!'); // 렌더링 확인용
    return Scaffold(
      appBar: _appBar(context),
      body: PostDetailBody(),
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(Icons.arrow_back_ios),
    ),
  );
}
