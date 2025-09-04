import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/post/reply/widgets/post_reply_card.dart';

class PostReplyBody extends StatelessWidget {
  const PostReplyBody({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> comments = [
      {
        "commentId": "3",
        "author": {
          "username": "kyung_0414",
          "profileImageUrl": "https://i.pravatar.cc/150?u=kyung",
          "isPostAuthor": false,
        },
        "content": "윤슬 왜케 잘 찍어",
        "createdAt": "38주",
        "isLiked": false,
        "replies": [
          {
            "commentId": "5",
            "author": {
              "username": "9912151n_",
              "profileImageUrl": "https://i.pravatar.cc/150?u=author",
              "isPostAuthor": true,
            },
            "content": "@kyung_0414 날씨와 휴대폰만 있다면,,",
            "createdAt": "38주",
            "isLiked": false,
          },
        ],
      },
      {
        "commentId": "2",
        "author": {
          "username": "hyonosy",
          "profileImageUrl": "https://i.pravatar.cc/150?u=hyonosy",
          "isPostAuthor": false,
        },
        "content": "이 게시물 너무 좋아요",
        "createdAt": "38주",
        "isLiked": false,
        "replies": [
          {
            "commentId": "1",
            "author": {
              "username": "9912151n_",
              "profileImageUrl": "https://i.pravatar.cc/150?u=author2",
              "isPostAuthor": true,
            },
            "content": "@hyonosy 난 네가 좋아 ^^*",
            "createdAt": "38주",
            "isLiked": false,
          },
        ],
      },
    ];

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(MSize.kGap.m),
            itemCount: comments.length,
            itemBuilder: (context, index) {
              final comment = comments[index];
              return PostReplyCard(comment: comment);
            },
          ),
        ),

        Divider(height: MSize.kLine.normal),

        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MSize.kGap.m, vertical: MSize.kGap.xs),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=3"),
                ),
                SizedBox(width: MSize.kGap.xs),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "회원님의 생각을 남겨보세요.",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    print("댓글 전송");
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
