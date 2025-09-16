import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/holder/profile/profile_vm.dart';
import 'package:minigram/ui/pages/post/detail/post_detail_page.dart';
import 'package:minigram/ui/pages/story/detail/story_detail_page.dart';
import 'package:minigram/ui/widgets/m_grid_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfileGridBuilder extends StatefulWidget {
  final bool isStoryTab;
  final ProfileModel profileModel;

  /// NestedScrollView와 연결하기 위해 SliverOverlapAbsorberHandle 전달
  final SliverOverlapAbsorberHandle injectorHandle;

  const ProfileGridBuilder({
    super.key,
    this.isStoryTab = false,
    required this.profileModel,
    required this.injectorHandle,
  });

  @override
  State<ProfileGridBuilder> createState() => _ProfileGridBuilderState();
}

class _ProfileGridBuilderState extends State<ProfileGridBuilder> {
  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  Future<void> _onLoading() async {
    // TODO: 추가 데이터 로딩 로직 (API 호출 후 setState)
    await Future.delayed(const Duration(milliseconds: 1500));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    final storyList = widget.profileModel.storyListObject.storyList;
    final postList = widget.profileModel.postListObject.postList;

    if (widget.isStoryTab) {
      // 스토리 탭
      return SmartRefresher(
        controller: _refreshController,
        enablePullDown: false,
        enablePullUp: true,
        onLoading: _onLoading,
        child: CustomScrollView(
          key: PageStorageKey<String>("storyTab"),
          slivers: [
            SliverOverlapInjector(handle: widget.injectorHandle),
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
      // 게시글 탭
      return SmartRefresher(
        controller: _refreshController,
        enablePullDown: false,
        enablePullUp: true,
        onLoading: _onLoading,
        child: CustomScrollView(
          key: PageStorageKey<String>("postTab"),
          slivers: [
            SliverOverlapInjector(handle: widget.injectorHandle),
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
