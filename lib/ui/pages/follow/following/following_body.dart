import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/follow/following/following_card_item.dart';
import 'package:minigram/ui/pages/follow/widgets/m_follow_search_bar.dart';

class FollowingBody extends StatelessWidget {
  const FollowingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: MFollowSearchBar(), // 검색바
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => FollowingCardItem(),
            childCount: 20,
          ),
        ),
      ],
    );
  }
}
