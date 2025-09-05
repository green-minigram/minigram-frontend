import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/follow/follwer/follower_card_item.dart';
import 'package:minigram/ui/pages/follow/widgets/m_follow_search_bar.dart';

class FollowerBody extends StatefulWidget {
  const FollowerBody({super.key});

  @override
  State<FollowerBody> createState() => _FollowerBodyState();
}

class _FollowerBodyState extends State<FollowerBody> {
  String query = "";

  @override
  Widget build(BuildContext context) {
    // 더미 데이터 (나중에 서버 연동 시 교체)
    final int totalFollowersCount = 10;

    return Column(
      children: [
        MFollowSearchBar(
          onChanged: (value) {
            setState(() {
              query = value;
            });
            print("검색어(Follower): $value");
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: totalFollowersCount,
            itemBuilder: (context, index) {
              // 나중에 query 기반 필터링 적용
              return FollowerCardItem();
            },
          ),
        ),
      ],
    );
  }
}
