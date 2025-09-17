import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/data/model/post.dart';
import 'package:minigram/ui/pages/post/detail/post_detail_vm.dart';
import 'package:minigram/ui/pages/post/detail/widgets/post_detail_body.dart';
import 'package:minigram/ui/widgets/m_app_bar_bottom_line.dart';
import 'package:minigram/ui/widgets/m_button.dart';

class PostDetailPage extends ConsumerWidget {
  final int postId;

  const PostDetailPage({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(postDetailProvider(postId));

    if (detail == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final post = detail.toPost();

    return Scaffold(
      appBar: _appBar(context, post),
      body: PostDetailBody(post: post),
    );
  }

  AppBar _appBar(BuildContext context, Post post) => AppBar(
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.arrow_back_ios),
    ),
    title: Column(
      children: [
        const Text('게시물'),
        Text(
          post.user.username,
          style: TextStyle(
            color: MColor.kText.normal,
            fontSize: MSize.kFont.m,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
    actions: [
      MButton(
        onPressed: () {
          print("팔로우 버튼 클릭됨");
        },
        text: post.user.isFollowing == true ? "팔로잉" : "팔로우",
        textColor: MColor.kText.normal,
        borderRadius: MSize.kBorderRadius.s,
        backgroundColor: MColor.kButton.disabled,
        padding: EdgeInsets.symmetric(horizontal: MSize.kGap.l),
      ),
      SizedBox(width: MSize.kGap.m),
    ],
    bottom: const MAppBarBottomLine(),
  );
}
