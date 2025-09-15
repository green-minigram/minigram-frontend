import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/data/gvm/recent_search_gvm.dart';
import 'package:minigram/ui/pages/holder/search/search_fm.dart';

class RecentSearchesSliver extends ConsumerWidget {
  const RecentSearchesSliver({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentSearchList = ref.watch(recentSearchProvider).recentSearchList;

    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(
              top: MSize.kGap.xxl,
              left: MSize.kGap.l,
              right: MSize.kGap.l,
            ),
            child: Text(
              "최근 검색",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: MSize.kFont.xl,
              ),
            ),
          ),
        ),
        recentSearchList.isEmpty
            ? SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MSize.kGap.xl,
                    horizontal: MSize.kGap.l,
                  ),
                  child: Text(
                    "최근 검색어가 없습니다.",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            : SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final keyword = recentSearchList[index];
                    return InkWell(
                      onTap: () {
                        ref
                            .read(searchFormProvider.notifier)
                            .submitSearch(value: keyword);
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: MSize.kGap.l,
                        ),
                        leading: Icon(Icons.history),
                        title: Text(keyword),
                        trailing: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            ref
                                .read(recentSearchProvider.notifier)
                                .remove(keyword);
                          },
                        ),
                      ),
                    );
                  },
                  childCount: recentSearchList.length,
                ),
              ),
      ],
    );
  }
}
