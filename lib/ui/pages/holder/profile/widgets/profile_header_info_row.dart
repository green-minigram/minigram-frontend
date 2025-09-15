import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/holder/profile/profile_vm.dart';

class ProfileHeaderInfoRow extends StatelessWidget {
  final ProfileModel profileModel;
  const ProfileHeaderInfoRow({
    super.key,
    required this.profileModel,
  });

  @override
  Widget build(BuildContext context) {
    final profile = profileModel.profile;

    return Row(
      spacing: MSize.kGap.huge,
      children: [
        _buildInkWell(count: profile.postCount, text: "게시물"),
        _buildInkWell(count: profile.followerCount, text: "팔로우"),
        _buildInkWell(count: profile.followingCount, text: "팔로잉"),
      ],
    );
  }

  /// TODO : url을 받지 말고 팔로잉 페이지로 이동하는 함수를 받아서 호출하자
  InkWell _buildInkWell({
    required int count,
    required String text,
    String url = "",
  }) {
    return InkWell(
      onTap: () {},
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
