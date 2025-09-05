import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/holder/search/widgets/m_search_bar.dart';
import 'package:minigram/ui/pages/holder/search/widgets/recent_search_sliver.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 75,
          collapsedHeight: 75,
          pinned: false,
          flexibleSpace: MSearchBar(),
          surfaceTintColor: Colors.transparent,
        ),
        RecentSearchesSliver(), // 검색어가 존재하면 보이는 화면
        // PostGridSliver(), // 제일 처음 보이는 화면
      ],
    );
  }
}
