import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/post/update/widgets/post_update_body.dart';

class PostUpdatePage extends StatelessWidget {
  const PostUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: PostUpdateBody(
        initialText: "기존 게시글 내용이에요",
        initialImages: [
          "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_1280.jpg",
          "https://cdn.pixabay.com/photo/2025/08/21/09/51/rouen-cathedral-9787080_1280.jpg",
        ],
      ),
    );
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
      leading: TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(
          "취소",
          style: TextStyle(
            color: MColor.kText.blue,
            fontSize: MSize.kFont.m,
          ),
        ),
      ),
      title: Text('정보 수정'),
      actions: [
        TextButton(
          onPressed: () {
            print("수정 클릭됨");
          },
          child: Text(
            "수정",
            style: TextStyle(
              color: MColor.kText.blue,
              fontSize: MSize.kFont.m,
            ),
          ),
        ),
      ],
    );
  }
}
