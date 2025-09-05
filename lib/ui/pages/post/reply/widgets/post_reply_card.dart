import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/_core/util/m_date.dart';
import 'package:minigram/ui/pages/post/reply/widgets/post_reply_child_card.dart';
import 'package:minigram/ui/widgets/m_story.dart';

class PostReplyCard extends StatefulWidget {
  final Map<String, dynamic> comment;

  // 부모(PostReplyBody)로 전달할 콜백 추가
  final void Function(String username)? onReplyTap;
  final void Function(String? commentId)? onHighlightChange; // ✅ 부모에 전달
  final bool isHighlighted; // ✅ 강조 여부 (부모에서 제어)

  const PostReplyCard({
    super.key,
    required this.comment,
    this.onReplyTap,
    this.onHighlightChange,
    this.isHighlighted = false,
  });

  @override
  State<PostReplyCard> createState() => _PostReplyCardState();
}

class _PostReplyCardState extends State<PostReplyCard> {
  bool _showReplies = false;

  // ✅ 액션 시트 열기
  void _showActionSheet(Offset tapOffset) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    void closeSheet() {
      entry.remove();
      widget.onHighlightChange?.call(null); // 닫을 때 강조 해제
    }

    entry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // 배경 블러 + 딤
            Positioned.fill(
              child: GestureDetector(
                onTap: closeSheet,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(color: Colors.black.withOpacity(0.3)),
                ),
              ),
            ),

            // 댓글 기준 액션 시트
            Positioned(
              left: 16,
              right: 16,
              top: tapOffset.dy,
              child: Material(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: const Text("좋아요"),
                      trailing: const Icon(Icons.favorite_border),
                      onTap: () {
                        print("좋아요: ${widget.comment["commentId"]}");
                        closeSheet();
                      },
                    ),
                    ListTile(
                      title: const Text("답글 달기"),
                      trailing: const Icon(Icons.reply),
                      onTap: () {
                        widget.onReplyTap?.call(widget.comment["author"]["username"]);
                        closeSheet();
                      },
                    ),
                    ListTile(
                      title: const Text("삭제", style: TextStyle(color: Colors.red)),
                      trailing: const Icon(Icons.delete, color: Colors.red),
                      onTap: () {
                        print("삭제: ${widget.comment["commentId"]}");
                        closeSheet();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );

    overlay.insert(entry);
  }

  @override
  Widget build(BuildContext context) {
    final author = widget.comment["author"];
    final List<dynamic> replies = widget.comment["replies"] ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: MSize.kGap.xs),
          child: GestureDetector(
            onLongPressStart: (details) {
              widget.onHighlightChange?.call(widget.comment["commentId"]); // ✅ 부모에 강조 요청
              _showActionSheet(details.globalPosition);
            },

            // ✅ 강조 표시
            child: Container(
              color: widget.isHighlighted ? Colors.grey.withOpacity(0.2) : Colors.transparent,
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

                        // 셋째 줄: 답글 달기 버튼
                        Padding(
                          padding: EdgeInsets.only(top: MSize.kGap.xxxs),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(MSize.kBorderRadius.xxs),
                            onTap: () {
                              widget.onReplyTap?.call(author["username"]);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: MSize.kGap.xxxxs, horizontal: 4),
                              child: Text(
                                "답글 달기",
                                style: TextStyle(
                                  color: MColor.kText.secondary,
                                  fontSize: MSize.kFont.s,
                                ),
                              ),
                            ),
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
                                    height: MSize.kLine.normal,
                                    width: MSize.kLine.width16,
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
          ),
        ),

        // 대댓글 리스트 (토글 시 표시)
        if (_showReplies)
          Padding(
            padding: EdgeInsets.only(left: MSize.kGap.huge),
            child: Column(
              children: replies
                  .map(
                    (reply) => PostReplyChildCard(
                      reply: reply,
                      onReplyTap: widget.onReplyTap,
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }
}
