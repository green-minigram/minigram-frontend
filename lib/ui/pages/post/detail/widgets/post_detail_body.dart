import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/post/widgets/post_footer.dart';
import 'package:minigram/ui/pages/post/widgets/post_header.dart';
import 'package:minigram/ui/pages/post/widgets/post_image.dart';

class PostDetailBody extends StatelessWidget {
  const PostDetailBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
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
