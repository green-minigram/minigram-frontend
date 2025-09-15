import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/holder/profile/profile_vm.dart';
import 'package:minigram/ui/pages/holder/profile/widgets/profile_header_info_row.dart';
import 'package:minigram/ui/widgets/m_story.dart';

class ProfileHeaderInfo extends StatelessWidget {
  final ProfileModel profileModel;

  const ProfileHeaderInfo({
    super.key,
    required this.profileModel,
  });

  @override
  Widget build(BuildContext context) {
    final profile = profileModel.profile;
    return Row(
      spacing: MSize.kGap.l,
      children: [
        MStory(
          imageUrl: profile.profileImageUrl,
          size: 100,
          userId: profile.userId, // TODO userId 필요
          isGradient: false, // 새로운 스토리가 있으면 true
        ),
        ProfileHeaderInfoRow(profileModel: profileModel),
      ],
    );
  }
}
