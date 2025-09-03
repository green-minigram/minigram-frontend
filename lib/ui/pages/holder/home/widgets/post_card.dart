import 'package:flutter/material.dart';
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
        const SizedBox(height: 8),
        PostHeader(),
        const SizedBox(height: 8),
        PostImage(),
        const SizedBox(height: 8),
        PostFooter(),
      ],
    );
  }
}
