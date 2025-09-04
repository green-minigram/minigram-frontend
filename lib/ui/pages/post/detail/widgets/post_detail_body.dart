import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/post/widgets/post_footer.dart';
import 'package:minigram/ui/pages/post/widgets/post_header.dart';
import 'package:minigram/ui/pages/post/widgets/post_image.dart';

class PostDetailBody extends StatelessWidget {
  const PostDetailBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: MSize.kGap.xs),
        PostHeader(showFollowButton: false),
        SizedBox(height: MSize.kGap.xs),
        PostImage(),
        SizedBox(height: MSize.kGap.xs),
        PostFooter(),
      ],
    );
  }
}
