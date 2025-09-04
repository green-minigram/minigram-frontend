import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/post/reply/widgets/post_reply_child_card.dart';
import 'package:minigram/ui/widgets/m_story.dart';

class PostReplyCard extends StatefulWidget {
  final Map<String, dynamic> comment;

  const PostReplyCard({super.key, required this.comment});

  @override
  State<PostReplyCard> createState() => _PostReplyCardState();
}

class _PostReplyCardState extends State<PostReplyCard> {
  bool _showReplies = false;

  @override
  Widget build(BuildContext context) {
    final author = widget.comment["author"];
    final List<dynamic> replies = widget.comment["replies"] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 원댓글
        Padding(
          padding: EdgeInsets.symmetric(vertical: MSize.kGap.xs),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 프로필
              MStory(
                size: MSize.kStory.s,
                imageUrl: author["profileImageUrl"],
                isGradient: false,
              ),
              SizedBox(width: MSize.kGap.xs),

              // 댓글 본문
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 첫 줄: 닉네임 + 댓글 내용
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
                          TextSpan(text: widget.comment["content"]),
                        ],
                      ),
                    ),
                    SizedBox(height: MSize.kGap.xxxs),

                    // 둘째 줄: 작성시간 + 답글 달기 + 작성자
                    Row(
                      children: [
                        Text(
                          widget.comment["createdAt"],
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

                    // 대댓글 토글 버튼
                    if (replies.isNotEmpty) ...[
                      SizedBox(height: MSize.kGap.xs),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _showReplies = !_showReplies;
                          });
                        },
                        child: Text(
                          _showReplies ? "답글 숨기기" : "답글 ${replies.length}개 보기",
                          style: TextStyle(
                            color: MColor.kText.secondary,
                            fontSize: MSize.kFont.s,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // 좋아요 버튼
              IconButton(
                icon: Icon(
                  widget.comment["isLiked"] ? Icons.favorite : Icons.favorite_border,
                  size: MSize.kIcon.m,
                  color: widget.comment["isLiked"] ? MColor.kButton.like : MColor.kText.secondary,
                ),
                onPressed: () {
                  print("댓글 좋아요: ${widget.comment["commentId"]}");
                },
              ),
            ],
          ),
        ),

        // 대댓글 리스트 (토글 시 표시)
        if (_showReplies)
          Padding(
            padding: EdgeInsets.only(left: MSize.kGap.huge),
            child: Column(
              children: replies.map((reply) => PostReplyChildCard(reply: reply)).toList(),
            ),
          ),
      ],
    );
  }
}
