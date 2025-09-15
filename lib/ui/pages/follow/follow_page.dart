import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/follow/widgets/follow_body.dart';

class FollowPage extends StatelessWidget {
  final int followerCount;
  final int followingCount;
  final int userId;
  final String username;
  const FollowPage({
    super.key,
    required this.followerCount,
    required this.followingCount,
    required this.userId,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // 팔로워, 팔로잉
      child: Scaffold(
        appBar: _appbar(context),
        body: FollowBody(userId: userId),
      ),
    );
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "${username}",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: MSize.kFont.l,
        ),
      ),
      centerTitle: true,
      bottom: TabBar(
        indicatorColor: Colors.black,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,
        tabs: [
          // TODO 팔로워 팔로잉 숫자는 상세페이지에서 가져와야 할 듯
          Tab(text: "팔로워 ${followerCount}"),
          Tab(text: "팔로잉 ${followingCount}"),
        ],
      ),
    );
  }
}
