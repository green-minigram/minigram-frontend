import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/_core/util/m_date.dart';
import 'package:minigram/data/model/post.dart';
import 'package:minigram/ui/pages/post/reply/post_comment_page.dart';

class PostFooter extends StatefulWidget {
  final Post post;

  const PostFooter({
    super.key,
    required this.post,
  });

  @override
  State<PostFooter> createState() => _PostFooterState();
}

class _PostFooterState extends State<PostFooter> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    Post post = widget.post;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MSize.kGap.l,
        vertical: MSize.kGap.xs,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 좋아요 & 댓글
          Row(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      print("좋아요 아이콘 클릭됨");
                    },
                    child: Icon(
                      Icons.favorite,
                      color: MColor.kButton.like,
                      size: MSize.kIcon.s,
                    ),
                  ),
                  SizedBox(width: MSize.kGap.xxs),
                  Text(
                    "${post.likesCount}",
                    style: TextStyle(color: MColor.kText.title),
                  ),
                ],
              ),
              SizedBox(width: MSize.kGap.l),
              TextButton.icon(
                onPressed: () {
                  print("댓글 버튼 클릭됨");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PostCommentPage()),
                  );
                },
                icon: Icon(
                  Icons.mode_comment_outlined,
                  size: MSize.kIcon.s,
                  color: MColor.kIcon.normal,
                ),
                label: Text(
                  "${post.commentCount}",
                  style: TextStyle(color: MColor.kText.title),
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ), // 댓글 수
            ],
          ),
          SizedBox(height: MSize.kGap.xxs),

          // 글 내용 + 좋아요 + 댓글 + 날짜
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 아이디
              Text(
                "${post.user.username}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MSize.kFont.m,
                ),
              ),
              SizedBox(height: MSize.kGap.xxs),

              // 본문 자리
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      _expanded
                          ? (post.content ?? "")
                          : ((post.content ?? "").length > 30
                                ? (post.content ?? "").substring(0, 30) + "..."
                                : (post.content ?? "")),
                    ),
                  ),
                  if (!_expanded && (post.content ?? "").length > 30)
                    GestureDetector(
                      onTap: () => setState(() => _expanded = true),
                      child: Text(" 더 보기"),
                    ),
                ],
              ),
            ],
          ),
          SizedBox(height: MSize.kGap.xxs),

          // 날짜
          Text(
            "${MDate.timeAgo(post.createdAt)}",
            style: TextStyle(
              fontSize: MSize.kFont.s,
              color: MColor.kText.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
