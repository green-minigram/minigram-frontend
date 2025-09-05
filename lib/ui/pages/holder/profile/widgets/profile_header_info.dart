import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/holder/profile/widgets/profile_header_info_row.dart';
import 'package:minigram/ui/widgets/m_story.dart';

class ProfileHeaderInfo extends StatelessWidget {
  const ProfileHeaderInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: MSize.kGap.l,
      children: [
        MStory(
          imageUrl: "https://cdn.pixabay.com/photo/2025/08/12/08/49/cat-9769723_1280.jpg",
          size: 100,
        ),
        ProfileHeaderInfoRow(),
      ],
    );
  }
}
