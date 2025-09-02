import 'package:flutter/material.dart';

class PostFooter extends StatefulWidget {
  PostFooter({super.key});

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
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 좋아요 & 댓글
          Row(
            children: [
              Icon(Icons.favorite, color: Colors.red, size: 20),
              SizedBox(width: 4),
              Text("3.2만"), // 좋아요 수
              SizedBox(width: 16),
              Icon(Icons.mode_comment_outlined, size: 20),
              SizedBox(width: 4),
              Text("301"), // 댓글 수
            ],
          ),
          SizedBox(height: 6),

          // 글 내용 + 좋아요 + 댓글 + 날짜
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 아이디
              Text(
                "아이디입니다",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              SizedBox(height: 4),

              // 본문 자리
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 본문
                  Expanded(
                    child: Text(
                      _expanded ? content : (content.length > 30 ? content.substring(0, 30) + "..." : content),
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),

                  // 더보기 버튼 길이 제한 일단 30자로 더 짧으면 안보이게
                  if (!_expanded && content.length > 30)
                    GestureDetector(
                      onTap: () => setState(() => _expanded = true),
                      child: const Text(
                        " 더 보기",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                ],
              ),
            ],
          ),
          SizedBox(height: 6),

          // 날짜
          Text(
            "8월 20일",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
