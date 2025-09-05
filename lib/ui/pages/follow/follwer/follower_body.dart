import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/follow/follwer/follower_card_item.dart';
import 'package:minigram/ui/pages/follow/widgets/m_follow_search_bar.dart';

class FollowerBody extends StatelessWidget {
  const FollowerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: MFollowSearchBar(), // 검색바
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => FollowerCardItem(),
            childCount: 20,
          ),
        ),
      ],
    );
  }
}
