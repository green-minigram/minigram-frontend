import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/widgets/m_story.dart';

class PostReplyChildCard extends StatelessWidget {
  final Map<String, dynamic> reply;

  const PostReplyChildCard({super.key, required this.reply});

  @override
  Widget build(BuildContext context) {
    final author = reply["author"];

    return Padding(
      padding: EdgeInsets.symmetric(vertical: MSize.kGap.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 프로필 이미지
          MStory(
            size: MSize.kStory.s * 0.8,
            imageUrl: author["profileImageUrl"],
            isGradient: false,
          ),
          SizedBox(width: MSize.kGap.xs),

          // 댓글 본문
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ 첫 줄: 닉네임 + 댓글 내용
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: MColor.kText.normal,
                      fontSize: MSize.kFont.normal,
                    ),
                    children: [
                      TextSpan(
                        text: "${author["username"]} ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MColor.kText.normal,
                        ),
                      ),
                      TextSpan(text: reply["content"]),
                    ],
                  ),
                ),

                SizedBox(height: MSize.kGap.xxxs),

                // ✅ 둘째 줄: 작성시간 + 답글 달기 + 작성자
                Row(
                  children: [
                    Text(
                      reply["createdAt"],
                      style: TextStyle(
                        color: MColor.kText.secondary,
                        fontSize: MSize.kFont.s,
                      ),
                    ),
                    SizedBox(width: MSize.kGap.s),
                    Text(
                      "답글 달기",
                      style: TextStyle(
                        color: MColor.kText.secondary,
                        fontSize: MSize.kFont.s,
                      ),
                    ),
                    if (author["isPostAuthor"] == true) ...[
                      SizedBox(width: MSize.kGap.s),
                      Text(
                        "작성자",
                        style: TextStyle(
                          color: MColor.kText.description,
                          fontSize: MSize.kFont.s,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // 좋아요 버튼
          IconButton(
            icon: Icon(
              reply["isLiked"] ? Icons.favorite : Icons.favorite_border,
              size: MSize.kIcon.s,
              color: reply["isLiked"] ? MColor.kButton.like : MColor.kText.secondary,
            ),
            onPressed: () {
              print("대댓글 좋아요: ${reply["commentId"]}");
            },
          ),
        ],
      ),
    );
  }
}
