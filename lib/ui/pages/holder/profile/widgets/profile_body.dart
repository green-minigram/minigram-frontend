import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/holder/profile/widgets/profile_grid_builder.dart';
import 'package:minigram/ui/pages/holder/profile/widgets/profile_header_bio.dart';
import 'package:minigram/ui/pages/holder/profile/widgets/profile_header_button.dart';
import 'package:minigram/ui/pages/holder/profile/widgets/profile_header_info.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({
    super.key,
    required this.isMe,
  });

  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: MSize.kGap.l),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                ProfileHeaderInfo(),
                ProfileHeaderBio(),
                ProfileHeaderButton(isMe: isMe),
              ]),
            ),
          ),
        ];
      },
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(icon: Icon(Icons.grid_on_rounded)), // 게시글
                Tab(icon: Icon(Icons.video_library_rounded)), // 스토리
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ProfileGridBuilder(isStoryTab: false), // 게시글 탭
                  ProfileGridBuilder(isStoryTab: true), // 스토리 탭
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
