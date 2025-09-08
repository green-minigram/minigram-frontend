import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/post/reply/post_comment_page.dart';

class PostFooter extends StatefulWidget {
  PostFooter({
    super.key,
  });

  @override
  State<PostFooter> createState() => _PostFooterState();
}

class _PostFooterState extends State<PostFooter> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    String content =
        "실연 당한 남성에게 “하늘 날 수 있다” 조언 긴 텍스트 예시입니다. "
        "여기서 내용이 길어지면 더보기 버튼을 눌러야 전체가 보이게 됩니다.";

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MSize.kGap.l, vertical: MSize.kGap.xs),
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
                    "3.2만",
                    style: TextStyle(color: MColor.kText.title),
                  ),
                ],
              ),
              SizedBox(width: MSize.kGap.l),
              TextButton.icon(
                onPressed: () {
                  print("댓글 버튼 클릭됨");
                  Navigator.push(context, MaterialPageRoute(builder: (_) => PostCommentPage()));
                },
                icon: Icon(
                  Icons.mode_comment_outlined,
                  size: MSize.kIcon.s,
                  color: MColor.kIcon.normal,
                ),
                label: Text(
                  "301",
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
                "아이디입니다",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: MSize.kFont.m),
              ),
              SizedBox(height: MSize.kGap.xxs),

              // 본문 자리
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      _expanded ? content : (content.length > 30 ? content.substring(0, 30) + "..." : content),
                    ),
                  ),
                  if (!_expanded && content.length > 30)
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
            "8월 20일",
            style: TextStyle(fontSize: MSize.kFont.s, color: MColor.kText.secondary),
          ),
        ],
      ),
    );
  }
}
