import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';

class RecentSearchesSliver extends StatelessWidget {
  const RecentSearchesSliver({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: MSize.kFont.xl),
            ),
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return InkWell(
                onTap: () {},
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: MSize.kGap.l),
                  leading: Icon(Icons.history),
                  title: Text("검색"),
                  trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      // 삭제 로직은 상위 위젯에서 관리하도록 콜백 함수를 추가할 수 있습니다.
                    },
                  ),
                ),
              );
            },
            childCount: 30,
          ),
        ),
      ],
    );
  }
}
