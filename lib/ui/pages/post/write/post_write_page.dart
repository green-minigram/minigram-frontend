import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/post/widgets/post_form_footer.dart';
import 'package:minigram/ui/pages/post/widgets/post_form_header.dart';
import 'package:minigram/ui/pages/post/widgets/post_form_image.dart';

class PostWritePage extends StatefulWidget {
  final List<String> imagePaths;

  const PostWritePage({super.key, required this.imagePaths});

  @override
  State<PostWritePage> createState() => _PostWritePageState();
}

class _PostWritePageState extends State<PostWritePage> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: ListView(
        children: [
          PostFormHeader(username: 'username'),
          PostFormImage(imagePaths: widget.imagePaths),
          PostFormFooter(
            controller: _textController,
            onSubmit: () {
              print("입력한 내용: ${_textController.text}");
            },
          ),
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
      title: const Text('업로드'),
      actions: [
        TextButton(
          onPressed: () {
            print("등록 클릭됨");
            print("내용: ${_textController.text}");
          },
          child: Text(
            "등록",
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
