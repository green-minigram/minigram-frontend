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
          "userId": "4",
          "username": "kyung_0414",
          "profileImageUrl": "https://i.pravatar.cc/150?u=kyung",
          "isPostAuthor": false,
        },
        "content": "윤슬 왜케 잘 찍어",
        "createdAt": "2023-11-20 10:00:00",
        "likesCount": 1,
        "isLiked": true,
        "isOwner": false,
        "replies": [
          {
            "commentId": "5",
            "author": {
              "userId": "5",
              "username": "9912151n_",
              "profileImageUrl": "https://i.pravatar.cc/150?u=author",
              "isPostAuthor": true,
            },
            "content": "날씨와 휴대폰만 있다면,,",
            "createdAt": "2023-11-20 10:01:00",
            "likesCount": 0,
            "isLiked": false,
            "isOwner": false,
          },
        ],
      },
      {
        "commentId": "2",
        "author": {
          "userId": "3",
          "username": "hyonosy",
          "profileImageUrl": "https://i.pravatar.cc/150?u=hyonosy",
          "isPostAuthor": false,
        },
        "content": "이 게시물 너무 좋아요",
        "createdAt": "2023-11-20 10:05:00",
        "likesCount": 2,
        "isLiked": false,
        "isOwner": false,
        "replies": [
          {
            "commentId": "1",
            "author": {
              "userId": "2",
              "username": "9912151n_",
              "profileImageUrl": "https://i.pravatar.cc/150?u=author2",
              "isPostAuthor": true,
            },
            "content": "난 네가 좋아 ^^*",
            "createdAt": "2023-11-20 10:06:00",
            "likesCount": 1,
            "isLiked": false,
            "isOwner": false,
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
                  radius: MSize.kBorderRadius.l,
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
