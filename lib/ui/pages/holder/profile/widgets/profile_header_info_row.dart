import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/follow/widgets/follow_body.dart';
import 'package:minigram/ui/pages/holder/profile/profile_vm.dart';

class ProfileHeaderInfoRow extends StatelessWidget {
  final ProfileModel profileModel;

  const ProfileHeaderInfoRow({
    super.key,
    required this.profileModel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: MSize.kGap.huge,
      children: [
        _buildInkWell(
          context: context,
          count: profileModel.profile.postCount,
          text: "게시물",
          profileModel: profileModel,
        ),
        _buildInkWell(
          context: context,
          count: profileModel.profile.followerCount,
          text: "팔로워",
          url: "follower",
          profileModel: profileModel,
        ),
        _buildInkWell(
          context: context,
          count: profileModel.profile.followingCount,
          text: "팔로잉",
          url: "following",
          profileModel: profileModel,
        ),
      ],
    );
  }

  InkWell _buildInkWell({
    required BuildContext context,
    required int count,
    required String text,
    required ProfileModel profileModel,
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
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios),
                    ),
                    title: Text(text),
                    bottom: TabBar(
                      tabs: [
                        Tab(text: "팔로워 ${profileModel.profile.followerCount}"),
                        Tab(text: "팔로잉 ${profileModel.profile.followingCount}"),
                      ],
                    ),
                  ),
                  body: FollowBody(userId: profileModel.profile.userId),
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
