import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/widgets/m_grid_item.dart';

class PostGridSliver extends StatelessWidget {
  const PostGridSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) => MGridItem(
          imageUrl: "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_960_720.jpg",
          onTap: () {},
        ),
        childCount: 30,
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
