import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/data/model/post.dart';
import 'package:minigram/ui/pages/post/widgets/post_footer.dart';
import 'package:minigram/ui/pages/post/widgets/post_header.dart';
import 'package:minigram/ui/pages/post/widgets/post_image.dart';

class PostCard extends StatelessWidget {
  Post post;

  PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MSize.kGap.xs),
        PostHeader(
          post: post,
          showFollowButton: post.user.showFollowButton ?? true,
        ),
        SizedBox(height: MSize.kGap.xs),
        PostImage(post: post),
        SizedBox(height: MSize.kGap.xs),
        PostFooter(post: post),
      ],
    );
  }
}
