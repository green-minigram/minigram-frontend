import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/follow/following/following_body.dart';
import 'package:minigram/ui/pages/follow/follwer/follower_body.dart';

class FollowBody extends StatelessWidget {
  final int userId;

  const FollowBody({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        FollowerBody(userId: userId),
        FollowingBody(userId: userId),
      ],
    );
  }
}
