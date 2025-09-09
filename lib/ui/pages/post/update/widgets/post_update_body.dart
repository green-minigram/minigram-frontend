import 'package:flutter/material.dart';
import 'package:minigram/ui/pages/post/widgets/post_form_footer.dart';
import 'package:minigram/ui/pages/post/widgets/post_form_header.dart';
import 'package:minigram/ui/pages/post/widgets/post_form_image.dart';

class PostUpdateBody extends StatefulWidget {
  final String initialText; // 기존 게시글 내용
  final List<String> initialImages; // 기존 이미지 경로/URL 리스트

  const PostUpdateBody({
    super.key,
    required this.initialText,
    required this.initialImages,
  });

  @override
  State<PostUpdateBody> createState() => _PostUpdateBodyState();
}

class _PostUpdateBodyState extends State<PostUpdateBody> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    // 기존 내용 세팅
    _textController = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _textController.dispose(); // 메모리 누수 방지
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        PostFormHeader(username: 'username'),
        // 기존 이미지 보여주기
        PostFormImage(imagePaths: widget.initialImages),
        // 기존 텍스트 보여주기
        PostFormFooter(
          controller: _textController,
          onSubmit: () {
            print("수정된 내용: ${_textController.text}");
          },
        ),
      ],
    );
  }
}
