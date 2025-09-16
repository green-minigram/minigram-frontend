import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/holder/profile/profile_vm.dart';
import 'package:minigram/ui/pages/post/detail/post_detail_page.dart';
import 'package:minigram/ui/pages/story/detail/story_detail_page.dart';
import 'package:minigram/ui/widgets/m_grid_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfileGridBuilder extends ConsumerWidget {
  final bool isStoryTab;
  final int userId;
  final SliverOverlapAbsorberHandle injectorHandle;

  const ProfileGridBuilder({
    super.key,
    this.isStoryTab = false,
    required this.userId,
    required this.injectorHandle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileModel = ref.watch(profileProvider(userId));
    final profileVM = ref.read(profileProvider(userId).notifier);

    if (profileModel == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final storyList = profileModel.storyListObject.storyList;
    final postList = profileModel.postListObject.postList;

    if (isStoryTab) {
      return SmartRefresher(
        controller: profileVM.storyScrollController,
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: () => profileVM.init(userId: userId),
        onLoading: () => profileVM.nextStoryList(userId: userId),
        child: CustomScrollView(
          key: const PageStorageKey<String>("storyTab"),
          slivers: [
            SliverOverlapInjector(handle: injectorHandle),
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
        ),
      );
    } else {
      return SmartRefresher(
        controller: profileVM.postScrollController,
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: () => profileVM.init(userId: userId),
        onLoading: () => profileVM.nextPostList(userId: userId),
        child: CustomScrollView(
          key: const PageStorageKey<String>("postTab"),
          slivers: [
            SliverOverlapInjector(handle: injectorHandle),
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
        ),
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
