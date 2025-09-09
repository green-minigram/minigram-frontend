import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/post/reply/widgets/post_comment_card.dart';
import 'package:minigram/ui/pages/post/reply/widgets/post_comment_input_bar.dart';

class PostCommentBody extends StatefulWidget {
  const PostCommentBody({super.key});

  @override
  State<PostCommentBody> createState() => _PostCommentBodyState();
}

class _PostCommentBodyState extends State<PostCommentBody> {
  final FocusNode _replyFocusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();

  String? _replyToUser;

  void _focusReplyField(String username) {
    setState(() {
      _replyToUser = username;
    });
    FocusScope.of(context).requestFocus(_replyFocusNode);
  }

  void _cancelReply() {
    setState(() {
      _replyToUser = null;
    });
    _replyFocusNode.unfocus();
  }

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
              return PostCommentCard(
                comment: comment,
                onReplyTap: (username) => _focusReplyField(username),
              );
            },
          ),
        ),

        Divider(height: MSize.kLine.normal),
        PostCommentInputBar(
          controller: _controller,
          focusNode: _replyFocusNode,
          replyToUser: _replyToUser,
          onCancelReply: _cancelReply,
          onSend: () {
            print("댓글 전송: ${_controller.text}");
            _controller.clear();
            _cancelReply();
          },
        ),
      ],
    );
  }
}
