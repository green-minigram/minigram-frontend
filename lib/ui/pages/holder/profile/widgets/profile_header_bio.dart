import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/holder/profile/profile_vm.dart';

class ProfileHeaderBio extends StatelessWidget {
  final ProfileModel profileModel;

  const ProfileHeaderBio({
    super.key,
    required this.profileModel,
  });

  @override
  Widget build(BuildContext context) {
    final profile = profileModel.profile;
    return Padding(
      padding: EdgeInsets.only(top: MSize.kGap.m),
      child: Text(
        "${profile.bio}",
        style: TextStyle(fontSize: MSize.kFont.m),
      ),
    );
  }
}
