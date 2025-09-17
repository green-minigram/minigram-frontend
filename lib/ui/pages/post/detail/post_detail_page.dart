import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/holder/search/search_vm.dart';
import 'package:minigram/ui/pages/post/detail/widgets/post_detail_body.dart';
import 'package:minigram/ui/widgets/m_app_bar_bottom_line.dart';
import 'package:minigram/ui/widgets/m_button.dart';

class PostDetailPage extends StatelessWidget {
  final SearchSimplePost post;

  const PostDetailPage({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    print('게시글 상세 페이지 렌더링됨! ${post.postId} 포스트 아이디'); // 렌더링 확인용
    return Scaffold(
      appBar: _appBar(context),
      body: PostDetailBody(),
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(Icons.arrow_back_ios),
    ),
    title: Column(
      children: [
        Text('게시물'),
        Text(
          'username',
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
        text: "팔로우",
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
