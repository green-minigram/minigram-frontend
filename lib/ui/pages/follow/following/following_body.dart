import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/follow/following/following_card_item.dart';
import 'package:minigram/ui/pages/follow/widgets/m_follow_search_bar.dart';

class FollowingBody extends StatefulWidget {
  const FollowingBody({super.key});

  @override
  State<FollowingBody> createState() => _FollowingBodyState();
}

class _FollowingBodyState extends State<FollowingBody> {
  String query = "";

  @override
  Widget build(BuildContext context) {
    // 더미 데이터
    final int totalFollowingCount = 10;

    return Column(
      children: [
        MFollowSearchBar(
          onChanged: (value) {
            setState(() {
              query = value;
            });
            print("검색어(Following): $value");
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: totalFollowingCount,
            itemBuilder: (context, index) {
              // 나중에 query 적용해서 필터링하면 됨
              return FollowingCardItem();
            },
          ),
        ),
      ],
    );
  }
}
