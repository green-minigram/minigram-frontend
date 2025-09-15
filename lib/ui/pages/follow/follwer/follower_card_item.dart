import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/follow/follow_vm.dart';
import 'package:minigram/ui/widgets/m_button.dart';

class FollowerCardItem extends StatefulWidget {
  final FollowUser user;
  const FollowerCardItem({super.key, required this.user});

  @override
  State<FollowerCardItem> createState() => _FollowerCardItemState();
}

class _FollowerCardItemState extends State<FollowerCardItem> {
  late bool isFollowing;

  @override
  void initState() {
    super.initState();
    isFollowing = widget.user.isFollowing;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MSize.kGap.s,
        horizontal: MSize.kGap.m,
      ),
      child: Row(
        children: [
          // 프로필 이미지 TODO 상세페이지 이동 넣을거면 추가해야 됨
          CircleAvatar(
            radius: 20,
            backgroundImage: widget.user.profileImageUrl != null
                ? NetworkImage(widget.user.profileImageUrl!)
                : null,
            child: widget.user.profileImageUrl == null
                ? Text(widget.user.username[0].toUpperCase())
                : null,
          ),
          SizedBox(width: MSize.kGap.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MSize.kFont.m,
                    color: MColor.kText.normal,
                  ),
                ),
                Text(
                  widget.user.name,
                  style: TextStyle(
                    fontSize: MSize.kFont.s,
                    color: MColor.kText.secondary,
                  ),
                ),
              ],
            ),
          ),
          // 팔로우 버튼
          if (!widget.user.isMe)
            MButton(
              onPressed: () {
                setState(() {
                  isFollowing = !isFollowing;
                });
              },
              text: isFollowing ? "팔로잉" : "팔로우",
              padding: EdgeInsets.symmetric(horizontal: MSize.kGap.xxl),
              borderRadius: MSize.kBorderRadius.s,
              backgroundColor: isFollowing
                  ? MColor.kButton.disabled
                  : MColor.kButton.primary,
              textColor: isFollowing ? MColor.kText.normal : MColor.kText.white,
            ),
        ],
      ),
    );
  }
}
