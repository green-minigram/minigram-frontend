import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/holder/profile/profile_vm.dart';
import 'package:minigram/ui/pages/post/detail/post_detail_page.dart';
import 'package:minigram/ui/pages/story/detail/story_detail_page.dart';
import 'package:minigram/ui/widgets/m_grid_item.dart';

class ProfileGridBuilder extends StatelessWidget {
  final bool isStoryTab;
  final ProfileModel profileModel;

  const ProfileGridBuilder({
    super.key,
    this.isStoryTab = false,
    required this.profileModel,
  });

  @override
  Widget build(BuildContext context) {
    final storyList = profileModel.storyListObject.storyList;
    final postList = profileModel.postListObject.postList;

    if (isStoryTab) {
      return CustomScrollView(
        slivers: [
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == storyList.length) {
                  return _AddBox();
                } else {
                  final item = storyList[index];
                  return MGridItem(
                    imageUrl: item.thumbnailUrl,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              StoryDetailPage(storyId: item.storyId),
                        ),
                      );
                    },
                  );
                }
              },
              childCount: storyList.length + 1,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: MSize.kRatio.aspect34,
              crossAxisSpacing: MSize.kGap.xxxs,
              mainAxisSpacing: MSize.kGap.xxxs,
            ),
          ),
        ],
      );
    } else {
      return CustomScrollView(
        slivers: [
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == postList.length) {
                  return _AddBox();
                } else {
                  final item = postList[index];
                  return MGridItem(
                    imageUrl: item.postImageUrl,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PostDetailPage(postId: item.postId),
                        ),
                      );
                    },
                  );
                }
              },
              childCount: postList.length + 1,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: MSize.kRatio.aspect34,
              crossAxisSpacing: MSize.kGap.xxxs,
              mainAxisSpacing: MSize.kGap.xxxs,
            ),
          ),
        ],
      );
    }
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
