import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/holder/profile/profile_vm.dart';
import 'package:minigram/ui/pages/holder/profile/widgets/profile_grid_builder.dart';
import 'package:minigram/ui/pages/holder/profile/widgets/profile_header_bio.dart';
import 'package:minigram/ui/pages/holder/profile/widgets/profile_header_button.dart';
import 'package:minigram/ui/pages/holder/profile/widgets/profile_header_info.dart';

class ProfileBody extends ConsumerWidget {
  final int userId;

  const ProfileBody({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileModel = ref.watch(profileProvider(userId));

    if (profileModel == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: MSize.kGap.l),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    ProfileHeaderInfo(profileModel: profileModel),
                    ProfileHeaderBio(profileModel: profileModel),
                    ProfileHeaderButton(profileModel: profileModel),
                  ]),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _TabBarDelegate(
                TabBar(
                  tabs: [
                    Tab(icon: Icon(Icons.grid_on_rounded)), // 게시글
                    Tab(icon: Icon(Icons.video_library_rounded)), // 스토리
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          children: [
            ProfileGridBuilder(
              isStoryTab: false,
              profileModel: profileModel,
            ),
            ProfileGridBuilder(
              isStoryTab: true,
              profileModel: profileModel,
            ),
          ],
        ),
      ),
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _TabBarDelegate(this._tabBar);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.white, // 배경색 필요시 지정
      child: _tabBar,
    );
  }

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(_TabBarDelegate oldDelegate) => false;
}
