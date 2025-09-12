import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/holder/home/home_vm.dart';
import 'package:minigram/ui/pages/holder/home/widgets/post_list.dart';
import 'package:minigram/ui/pages/holder/home/widgets/story_list.dart';
import 'package:minigram/ui/pages/notification/notification_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeBody extends ConsumerWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    HomeVM vm = ref.read(homeProvider.notifier);
    HomeModel? model = ref.watch(homeProvider);

    if (model == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return SmartRefresher(
        controller: vm.refreshCtrl,
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: () {
          vm.init();
        },
        onLoading: () {
          vm.nextPostList();
        },
        footer: const ClassicFooter(loadStyle: LoadStyle.ShowWhenLoading),
        child: CustomScrollView(
          slivers: [
            _sliverAppBar(context),
            StoryList(),
            SliverToBoxAdapter(child: SizedBox(height: MSize.kGap.xxxxs)),
            PostList(),
          ],
        ),
      );
    }
  }

  SliverAppBar _sliverAppBar(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      pinned: false, // 상단 고정
      floating: true, // 스크롤 조금 내려도 나타나게 하려면 true
      snap: true, // floating과 함께 snap 사용 가능
      leadingWidth: 150,
      leading: Padding(
        padding: EdgeInsets.only(left: MSize.kGap.m),
        child: Center(
          child: Text(
            "minigram",
            style: GoogleFonts.lobsterTwo(
              fontSize: MSize.kFont.xxxl,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications_none,
            color: Colors.black,
            size: MSize.kIcon.l,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NotificationPage(),
              ),
            );
          },
        ),
      ],
    );
  }
}
