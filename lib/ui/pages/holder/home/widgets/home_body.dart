import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/holder/home/widgets/post_list.dart';
import 'package:minigram/ui/pages/holder/home/widgets/story_list.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // 스토리 리스트
        StoryList(),
        SizedBox(height: MSizes.kGap.xs),
        PostList(),
      ],
    );
  }
}
