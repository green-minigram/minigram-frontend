import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart'; // 사이즈 상수
import 'package:minigram/ui/pages/holder/home/home_vm.dart';
import 'package:minigram/ui/widgets/m_story.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StoryList extends ConsumerWidget {
  const StoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    HomeModel? model = ref.watch(homeProvider);
    HomeVM vm = ref.read(homeProvider.notifier);

    return SliverToBoxAdapter(
      child: SizedBox(
        height: MSize.kStory.m + MSize.kGap.l + MSize.kFont.s,
        child: SmartRefresher(
          controller: vm.horizontalScrollController,
          enablePullDown: false,
          enablePullUp: true,
          onLoading: vm.nextPreviewList,
          footer: const ClassicFooter(loadStyle: LoadStyle.ShowWhenLoading),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: MSize.kGap.xs),
            itemCount: model!.storyObject.previewList.length,
            separatorBuilder: (_, __) => SizedBox(width: MSize.kGap.s),
            itemBuilder: (context, index) {
              final story = model!.storyObject.previewList[index];
              final username = story.username;
              final profileUrl = story.profileImageUrl;

              if (index == 0) {
                // 내 스토리
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        print("내 스토리 클릭됨");
                      },
                      child: Stack(
                        children: [
                          MStory(
                            size: MSize.kStory.m,
                            imageUrl: profileUrl,
                            isGradient: false,
                            userId: 2,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: MColor.kPrimary.normal,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: MColor.kNormal.white,
                                  width: MSize.kLine.normal,
                                ),
                              ),
                              child: Icon(
                                Icons.add,
                                color: MColor.kNormal.white,
                                size: MSize.kIcon.m,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MSize.kGap.xs),
                    Text(
                      "내 스토리",
                      style: TextStyle(fontSize: MSize.kFont.s),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                );
              }

              // 스토리들
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      print("$username 스토리 클릭됨");
                    },
                    child: MStory(
                      size: MSize.kStory.m,
                      imageUrl: profileUrl,
                      userId: 2,
                    ),
                  ),
                  SizedBox(height: MSize.kGap.xs),
                  Text(
                    username,
                    style: TextStyle(fontSize: MSize.kFont.s),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
