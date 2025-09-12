import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/holder/home/home_vm.dart';
import 'package:minigram/ui/pages/holder/home/widgets/post_card.dart';

class PostList extends ConsumerWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    HomeModel? model = ref.watch(homeProvider);

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(bottom: MSize.kGap.s),
            child: PostCard(
              post: model.postObject.postList[index],
            ),
          );
        },
        childCount: model!.postObject.postList.length,
      ),
    );
  }
}
