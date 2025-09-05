import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/follow/follwer/follower_card_item.dart';
import 'package:minigram/ui/pages/follow/widgets/m_follow_search_bar.dart';

class FollowerBody extends StatefulWidget {
  const FollowerBody({super.key});

  @override
  State<FollowerBody> createState() => _FollowerBodyState();
}

class _FollowerBodyState extends State<FollowerBody> {
  final TextEditingController _controller = TextEditingController();
  String query = "";

  void _onSearchChanged(String value) {
    setState(() => query = value);
    print("검색어(Follower): $value");
  }

  void _onClearSearch() {
    _controller.clear();
    setState(() => query = "");
  }

  @override
  Widget build(BuildContext context) {
    final int totalFollowersCount = 10;

    return ListView.builder(
      itemCount: totalFollowersCount + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          // 첫 번째는 검색바
          return MFollowSearchBar(
            controller: _controller,
            showClearButton: query.isNotEmpty,
            onChanged: _onSearchChanged,
            onClear: _onClearSearch,
          );
        }
        // 나머지는 카드 아이템
        return FollowerCardItem();
      },
    );
  }
}
