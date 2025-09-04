import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/widgets/m_button.dart';

class ProfileHeaderBtn extends StatelessWidget {
  const ProfileHeaderBtn({
    super.key,
    required this.isMe,
  });

  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MSize.kGap.l),
      child: Row(
        children: [
          Expanded(
            child: isMe
                ? MButton(
                    onPressed: () {},
                    text: "프로필 편집",
                    textColor: MColor.kText.normal,
                    backgroundColor: MColor.kBackGround.gray,
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
