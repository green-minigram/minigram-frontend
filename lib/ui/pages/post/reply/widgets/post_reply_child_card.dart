import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/_core/util/m_date.dart';
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
                // 첫 줄: 닉네임 + 작성시간
                Row(
                  children: [
                    Text(
                      author["username"],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: MSize.kFont.normal,
                        color: MColor.kText.normal,
                      ),
                    ),
                    SizedBox(width: MSize.kGap.xs),
                    Text(
                      MDate.timeAgo(reply["createdAt"]),
                      style: TextStyle(
                        fontSize: MSize.kFont.s,
                        color: MColor.kText.secondary,
                      ),
                    ),
                    if (author["isPostAuthor"] == true) ...[
                      SizedBox(width: MSize.kGap.xxs),
                      Text(
                        "· 작성자",
                        style: TextStyle(
                          color: MColor.kText.description,
                          fontSize: MSize.kFont.s,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),

                // 둘째 줄: 댓글 내용
                Padding(
                  padding: EdgeInsets.only(top: MSize.kGap.xxxs),
                  child: Text(
                    reply["content"],
                    style: TextStyle(
                      fontSize: MSize.kFont.normal,
                      color: MColor.kText.normal,
                    ),
                  ),
                ),

                // 셋째 줄: 답글 달기 + 작성자
                Padding(
                  padding: EdgeInsets.only(top: MSize.kGap.xxxs),
                  child: Row(
                    children: [
                      Text(
                        "답글 달기",
                        style: TextStyle(
                          color: MColor.kText.secondary,
                          fontSize: MSize.kFont.s,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 좋아요 버튼 + 좋아요 수
          Column(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(MSize.kBorderRadius.xl),
                onTap: () {
                  print("대댓글 좋아요: ${reply["commentId"]}");
                },
                child: Icon(
                  reply["isLiked"] ? Icons.favorite : Icons.favorite_border,
                  size: MSize.kIcon.m,
                  color: reply["isLiked"] ? MColor.kButton.like : MColor.kText.secondary,
                ),
              ),
              if ((reply["likesCount"] ?? 0) > 0) ...[
                SizedBox(height: MSize.kGap.xxxxs),
                Text(
                  "${reply["likesCount"]}",
                  style: TextStyle(
                    fontSize: MSize.kFont.s,
                    color: MColor.kText.secondary,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
