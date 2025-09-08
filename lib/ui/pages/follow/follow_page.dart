import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/follow/widgets/follow_body.dart';

class FollowPage extends StatelessWidget {
  const FollowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // 팔로워, 팔로잉
      child: Scaffold(
        appBar: _appbar(context),
        body: FollowBody(),
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
        "9912151n_",
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
          Tab(text: "팔로워 283"),
          Tab(text: "팔로잉 278"),
        ],
      ),
    );
  }
}
