import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/holder/profile/widgets/profile_grid_builder.dart';
import 'package:minigram/ui/pages/holder/profile/widgets/profile_header_bio.dart';
import 'package:minigram/ui/pages/holder/profile/widgets/profile_header_btn.dart';
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
                ProfileHeaderBtn(isMe: isMe),
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
                Tab(icon: Icon(Icons.grid_on_rounded)),
                Tab(icon: Icon(Icons.video_library_rounded)),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ProfileGridBuilder(),
                  ProfileGridBuilder(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
