import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/follow/widgets/follow_body.dart';

class ProfileHeaderInfoRow extends StatelessWidget {
  const ProfileHeaderInfoRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: MSize.kGap.huge,
      children: [
        _buildInkWell(
          context: context,
          count: 1,
          text: "게시물",
        ),
        _buildInkWell(
          context: context,
          count: 5,
          text: "팔로워",
          url: "follower",
        ),
        _buildInkWell(
          context: context,
          count: 9,
          text: "팔로잉",
          url: "following",
        ),
      ],
    );
  }

  InkWell _buildInkWell({
    required BuildContext context,
    required int count,
    required String text,
    String url = "",
  }) {
    return InkWell(
      onTap: () {
        if (url.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DefaultTabController(
                length: 2,
                initialIndex: url == "follower" ? 0 : 1,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text(text),
                    bottom: const TabBar(
                      tabs: [
                        Tab(text: "팔로워"),
                        Tab(text: "팔로잉"),
                      ],
                    ),
                  ),
                  body: const FollowBody(),
                ),
              ),
            ),
          );
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: MSize.kFont.xl,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: MSize.kFont.l,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
