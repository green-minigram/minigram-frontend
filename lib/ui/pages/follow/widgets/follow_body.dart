import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/follow/following/following_body.dart';
import 'package:minigram/ui/pages/follow/follwer/follower_body.dart';

class FollowBody extends StatelessWidget {
  const FollowBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        FollowerBody(),
        FollowingBody(),
      ],
    );
  }
}
