import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/follow/follow_vm.dart';
import 'package:minigram/ui/pages/follow/follwer/follower_card_item.dart';
import 'package:minigram/ui/pages/follow/widgets/m_follow_search_bar.dart';

class FollowerBody extends ConsumerStatefulWidget {
  final int userId;

  FollowerBody({
    super.key,
    required this.userId,
  });

  @override
  ConsumerState<FollowerBody> createState() => _FollowerBodyState();
}

class _FollowerBodyState extends ConsumerState<FollowerBody> {
  final TextEditingController _controller = TextEditingController();
  String query = "";

  void _onSearchChanged(String value) {
    setState(() => query = value);
  }

  void _onClearSearch() {
    _controller.clear();
    setState(() => query = "");
  }

  @override
  Widget build(BuildContext context) {
    final userId = widget.userId; // TODO: 현재 프로필 기준 userId 넘기기
    final followerState = ref.watch(followerProvider(userId));

    if (followerState == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // 검색어 필터링
    final filteredUsers = followerState
        .where(
          (user) =>
              user.username.toLowerCase().contains(query.toLowerCase()) ||
              user.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    return ListView(
      children: [
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
                style: TextStyle(
                  fontSize: MSize.kFont.m,
                  color: MColor.kText.description,
                ),
              ),
            ),
          )
        else
          ...filteredUsers.map(
            (user) => FollowerCardItem(user: user),
          ),
      ],
    );
  }
}
