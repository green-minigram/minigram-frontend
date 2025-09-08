import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';

class PostCommentItemLike extends StatelessWidget {
  final bool isLiked;
  final int likesCount;
  final VoidCallback onLike;

  const PostCommentItemLike({
    super.key,
    required this.isLiked,
    required this.likesCount,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(MSize.kBorderRadius.xl),
          onTap: onLike,
          child: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            size: MSize.kIcon.m,
            color: isLiked ? MColor.kButton.like : MColor.kText.secondary,
          ),
        ),
        if (likesCount > 0)
          Padding(
            padding: EdgeInsets.only(top: MSize.kGap.xxxxs),
            child: Text(
              "$likesCount",
              style: TextStyle(
                fontSize: MSize.kFont.s,
                color: MColor.kText.secondary,
              ),
            ),
          ),
      ],
    );
  }
}
