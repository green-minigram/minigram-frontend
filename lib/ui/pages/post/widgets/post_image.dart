import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/data/model/post.dart';

class PostImage extends StatelessWidget {
  final Post post;

  const PostImage({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    int currentPage = 0;

    final List<String> imageUrls = [
      "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_1280.jpg",
      "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_1280.jpg",
      "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_1280.jpg",
    ];

    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 600, // 최대 높이
              ),
              child: AspectRatio(
                aspectRatio: MSize.kRatio.aspect34,
                child: PageView.builder(
                  controller: pageController,
                  itemCount: post.postImageList.length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      post.postImageList[index].url,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: MSize.kGap.xs),

            // 넘기는거 표시하는 곳
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                imageUrls.length,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: MSize.kGap.xxs),
                  width: MSize.kGap.xs,
                  height: MSize.kGap.xs,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPage == index
                        ? MColor.kIndicator.active
                        : MColor.kIndicator.inactive,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
