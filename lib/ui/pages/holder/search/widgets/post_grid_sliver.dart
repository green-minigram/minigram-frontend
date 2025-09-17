import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/holder/search/search_fm.dart';
import 'package:minigram/ui/pages/holder/search/search_vm.dart';
import 'package:minigram/ui/pages/post/detail/post_detail_page.dart';
import 'package:minigram/ui/widgets/m_grid_item.dart';

class PostGridSliver extends ConsumerWidget {
  const PostGridSliver({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SearchModel? model = ref.watch(searchProvider);
    SearchFormModel formModel = ref.watch(searchFormProvider);

    if (model == null || formModel.isLoading) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) => MGridItem(
            imageUrl: model.postObject.postList[index].postImageUrl,
            onTap: () {
              print("아이템 클릭");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDetailPage(
                    post: model.postObject.postList[index],
                  ),
                ),
              );
            },
          ),
          childCount: model.postObject.postList.length,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: MSize.kRatio.aspect34,
          crossAxisSpacing: MSize.kGap.xxxs,
          mainAxisSpacing: MSize.kGap.xxxs,
        ),
      );
    }
  }
}
