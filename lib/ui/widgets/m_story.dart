import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/story/list/story_list_page.dart';

class MStory extends StatelessWidget {
  final double size;
  final String? imageUrl;
  final bool isGradient;

  const MStory({
    super.key,
    required this.size,
    this.imageUrl,
    this.isGradient = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(size / 2),
      onTap: () {
        print('스토리 클릭됨');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const StoryListPage(),
          ),
        );
      },
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: isGradient
              ? LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    MColor.kInsta.yellow,
                    MColor.kInsta.orange,
                    MColor.kInsta.red,
                    MColor.kInsta.pink,
                    MColor.kInsta.purple,
                  ],
                )
              : null,
        ),
        child: Padding(
          padding: EdgeInsets.all(MSize.kGap.xxxs),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: MColor.kNormal.white,
            ),
            child: Padding(
              padding: EdgeInsets.all(MSize.kGap.xxs),
              child: CircleAvatar(
                backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
                    ? NetworkImage(imageUrl!)
                    : const AssetImage('assets/images/base_profile.png')
                          as ImageProvider,
                radius: size / 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
