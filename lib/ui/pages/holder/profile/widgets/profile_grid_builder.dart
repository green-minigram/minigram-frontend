import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/post/detail/post_detail_page.dart';
import 'package:minigram/ui/pages/story/detail/story_detail_page.dart';
import 'package:minigram/ui/widgets/m_grid_item.dart';

class ProfileGridBuilder extends StatelessWidget {
  final bool isStoryTab;

  const ProfileGridBuilder({
    super.key,
    this.isStoryTab = false,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: MSize.kRatio.aspect34,
        crossAxisSpacing: MSize.kGap.xxxs,
        mainAxisSpacing: MSize.kGap.xxxs,
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        final imageUrl = "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_960_720.jpg";

        if (index == 8) {
          return _AddBox();
        } else {
          return MGridItem(
            imageUrl: imageUrl,
            onTap: () {
              if (isStoryTab) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => StoryDetailPage(storyId: 1), // TODO id 할당
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PostDetailPage(),
                  ),
                );
              }
            },
          );
        }
      },
    );
  }

  Material _AddBox() {
    return Material(
      color: MColor.kBackGround.lightGray,
      child: InkWell(
        onTap: () {
          print("추가하기 클릭됨");
        },
        child: const Center(
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
