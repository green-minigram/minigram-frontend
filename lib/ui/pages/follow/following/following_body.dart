import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/follow/following/following_card_item.dart';
import 'package:minigram/ui/pages/follow/widgets/m_follow_search_bar.dart';

class FollowingBody extends StatefulWidget {
  const FollowingBody({super.key});

  @override
  State<FollowingBody> createState() => _FollowingBodyState();
}

class _FollowingBodyState extends State<FollowingBody> {
  final TextEditingController _controller = TextEditingController();
  String query = "";

  void _onSearchChanged(String value) {
    setState(() => query = value);
    print("검색어(Following): $value");
  }

  void _onClearSearch() {
    _controller.clear();
    setState(() => query = "");
  }

  @override
  Widget build(BuildContext context) {
    // 더미 데이터
    final int totalFollowingCount = 10;

    return ListView.builder(
      itemCount: totalFollowingCount + 1,
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
        return FollowingCardItem();
      },
    );
  }
}
