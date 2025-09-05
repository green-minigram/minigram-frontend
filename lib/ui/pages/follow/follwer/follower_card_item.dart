import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/widgets/m_button.dart';
import 'package:minigram/ui/widgets/m_story.dart';

class FollowerCardItem extends StatelessWidget {
  const FollowerCardItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MSize.kGap.s,
        horizontal: MSize.kGap.m,
      ),
      child: Row(
        children: [
          // 프로필
          MStory(
            size: MSize.kStory.m,
          ),
          SizedBox(width: MSize.kGap.m),

          // 닉네임 + 이름
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "jay_Ong",
                  style: TextStyle(
                    fontSize: MSize.kFont.m,
                    fontWeight: FontWeight.bold,
                    color: MColor.kText.normal,
                  ),
                ),
                Text(
                  "정재용",
                  style: TextStyle(
                    fontSize: MSize.kFont.s,
                    color: MColor.kText.secondary,
                  ),
                ),
              ],
            ),
          ),

          // 팔로우 버튼
          MButton(
            onPressed: () {},
            text: '팔로우',
            padding: EdgeInsets.symmetric(horizontal: MSize.kGap.xxl),
            borderRadius: MSize.kBorderRadius.s,
          ),
        ],
      ),
    );
  }
}
