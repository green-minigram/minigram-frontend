import 'package:flutter/material.dart';

import 'post_card.dart';

class PostList extends StatelessWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      // 스크롤 중첩 방지
      shrinkWrap: true,
      // 내부 스크롤 크기만큼만 차지
      itemCount: 5,
      // 더미 게시글 개수
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: PostCard(),
        );
      },
    );
  }
}
