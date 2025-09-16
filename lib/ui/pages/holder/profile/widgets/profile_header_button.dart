import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/holder/profile/profile_vm.dart';
import 'package:minigram/ui/widgets/m_button.dart';

class ProfileHeaderButton extends StatelessWidget {
  const ProfileHeaderButton({
    super.key,
    required this.profileModel,
  });

  final ProfileModel profileModel;

  @override
  Widget build(BuildContext context) {
    final profile = profileModel.profile;
    return Padding(
      padding: EdgeInsets.only(top: MSize.kGap.l),
      child: Row(
        children: [
          Expanded(
            child: profile.isOwner
                ? MButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/profile/edit");
                    },
                    text: "프로필 편집",
                    textColor: MColor.kText.normal,
                    backgroundColor: MColor.kBackGround.lightGray,
                    padding: EdgeInsets.symmetric(vertical: MSize.kGap.xxxxs),
                  )
                : MButton(
                    onPressed: () {},
                    text: "팔로우",
                    padding: EdgeInsets.symmetric(vertical: MSize.kGap.xxxxs),
                  ),
          ),
        ],
      ),
    );
  }
}
