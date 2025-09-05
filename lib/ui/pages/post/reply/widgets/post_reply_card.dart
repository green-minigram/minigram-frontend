import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/_core/util/m_date.dart';
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

              // 본문
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
                          MDate.timeAgo(widget.comment["createdAt"]),
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
                              fontSize: MSize.kFont.s,
                              fontWeight: FontWeight.w600,
                              color: MColor.kText.description,
                            ),
                          ),
                        ],
                      ],
                    ),

                    // 둘째 줄: 댓글 내용
                    Padding(
                      padding: EdgeInsets.only(top: MSize.kGap.xxxs),
                      child: Text(
                        widget.comment["content"],
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
                              fontSize: MSize.kFont.s,
                              color: MColor.kText.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 넷째 줄: 대댓글 토글 버튼
                    if (replies.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: MSize.kGap.xxxs),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 0,
                              child: Container(
                                margin: EdgeInsets.only(right: MSize.kGap.xs),
                                height: 1,
                                width: 16,
                                color: MColor.kLine.main,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showReplies = !_showReplies;
                                });
                              },
                              child: Text(
                                _showReplies ? "답글 숨기기" : "답글 ${replies.length}개 더 보기",
                                style: TextStyle(
                                  fontSize: MSize.kFont.s,
                                  fontWeight: FontWeight.w500,
                                  color: MColor.kText.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),

              // 오른쪽 좋아요 버튼
              Column(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(MSize.kBorderRadius.xl),
                    onTap: () {
                      print("댓글 좋아요: ${widget.comment["commentId"]}");
                    },
                    child: Icon(
                      widget.comment["isLiked"] ? Icons.favorite : Icons.favorite_border,
                      size: MSize.kIcon.m,
                      color: widget.comment["isLiked"] ? MColor.kButton.like : MColor.kText.secondary,
                    ),
                  ),
                  if ((widget.comment["likesCount"] ?? 0) > 0) ...[
                    SizedBox(height: MSize.kGap.xxxxs),
                    Text(
                      "${widget.comment["likesCount"]}",
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
