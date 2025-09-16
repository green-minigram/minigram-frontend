import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/holder/profile/profile_vm.dart';
import 'package:minigram/ui/pages/holder/profile/widgets/profile_grid_builder.dart';
import 'package:minigram/ui/pages/holder/profile/widgets/profile_header_bio.dart';
import 'package:minigram/ui/pages/holder/profile/widgets/profile_header_button.dart';
import 'package:minigram/ui/pages/holder/profile/widgets/profile_header_info.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key, required this.profileModel});

  final ProfileModel profileModel;

  @override
  Widget build(BuildContext context) {
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
            Builder(
              builder: (context) {
                return ProfileGridBuilder(
                  isStoryTab: false,
                  profileModel: profileModel,
                  // 내부 SmartRefresher → CustomScrollView 안에 SliverOverlapInjector 필요
                  injectorHandle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                );
              },
            ),
            Builder(
              builder: (context) {
                return ProfileGridBuilder(
                  isStoryTab: true,
                  profileModel: profileModel,
                  injectorHandle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                );
              },
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
