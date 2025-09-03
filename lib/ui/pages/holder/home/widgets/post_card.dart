import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/post/widgets/post_footer.dart';
import 'package:minigram/ui/pages/post/widgets/post_header.dart';
import 'package:minigram/ui/pages/post/widgets/post_image.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MSize.kGap.xs),
        PostHeader(),
        SizedBox(height: MSize.kGap.xs),
        PostImage(),
        SizedBox(height: MSize.kGap.xs),
        PostFooter(),
      ],
    );
  }
}
