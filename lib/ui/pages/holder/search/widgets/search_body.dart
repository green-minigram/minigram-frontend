import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigram/ui/pages/holder/search/search_fm.dart';
import 'package:minigram/ui/pages/holder/search/search_vm.dart';
import 'package:minigram/ui/pages/holder/search/widgets/m_search_bar.dart';
import 'package:minigram/ui/pages/holder/search/widgets/post_grid_sliver.dart';
import 'package:minigram/ui/pages/holder/search/widgets/recent_search_sliver.dart';
import 'package:minigram/ui/widgets/m_app_bar_bottom_line.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchBody extends ConsumerWidget {
  const SearchBody({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SearchVM vm = ref.read(searchProvider.notifier);

    return SmartRefresher(
      controller: vm.verticalScrollController,
      enablePullDown: true,
      enablePullUp: true,
      onRefresh: vm.init,
      onLoading: vm.nextPostList,
      footer: const ClassicFooter(loadStyle: LoadStyle.ShowWhenLoading),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 75,
            collapsedHeight: 75,
            pinned: true,
            flexibleSpace: MSearchBar(),
            surfaceTintColor: Colors.transparent,
            bottom: const MAppBarBottomLine(),
          ),
          const ContentSwitcher(),
        ],
      ),
    );
  }
}

class ContentSwitcher extends ConsumerWidget {
  const ContentSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SearchFormModel searchFormModel = ref.watch(searchFormProvider);

    if (searchFormModel.isSearchMode) {
      return RecentSearchesSliver();
    } else {
      return PostGridSliver();
    }
  }
}
