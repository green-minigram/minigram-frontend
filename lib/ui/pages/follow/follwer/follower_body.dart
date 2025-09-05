import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
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

  // 더미 데이터 (임시)
  final List<String> dummyUsers = [
    "faker",
    "yoonjiiiiii",
    "yunakim",
    "travel_bellauri",
    "dex_xeb",
  ];

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
    // 검색어 필터링
    final filteredUsers = dummyUsers.where((user) => user.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView(
      children: [
        // 검색바도 리스트 첫 번째 아이템
        MFollowSearchBar(
          controller: _controller,
          showClearButton: query.isNotEmpty,
          onChanged: _onSearchChanged,
          onClear: _onClearSearch,
        ),

        if (filteredUsers.isEmpty)
          Padding(
            padding: EdgeInsets.all(MSize.kGap.xxl),
            child: Center(
              child: Text(
                "사용자를 찾을 수 없습니다",
                style: TextStyle(fontSize: MSize.kFont.m, color: MColor.kText.description),
              ),
            ),
          )
        else
          ...filteredUsers.map((user) => const FollowerCardItem()),
      ],
    );
  }
}
