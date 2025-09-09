import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/widgets/m_story.dart';

class PostFormHeader extends StatelessWidget {
  final String username;
  final String? profileImageUrl;

  const PostFormHeader({
    super.key,
    required this.username,
    this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MSize.kGap.m),
      child: Row(
        children: [
          // 프로필 (MStory 재사용)
          MStory(
            size: MSize.kStory.s,
            // imageUrl: profileImageUrl,
            isGradient: false,
          ),
          SizedBox(width: MSize.kGap.s),

          // 아이디
          Text(
            username,
            style: TextStyle(
              fontSize: MSize.kFont.normal,
              fontWeight: FontWeight.bold,
              color: MColor.kText.normal,
            ),
          ),
        ],
      ),
    );
  }
}
