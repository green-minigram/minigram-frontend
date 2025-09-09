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
  late List<String> _limitedImages;

  @override
  void initState() {
    super.initState();

    if (widget.imagePaths.length > 10) {
      _limitedImages = widget.imagePaths.take(10).toList();

      // 프레임 빌드 끝난 뒤 팝업 띄우기
      print('팝업창이 뜬다!!');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("알림"),
            content: Text(
              "사진은 최대 10장까지만 업로드할 수 있습니다.\n"
              "추가 ${widget.imagePaths.length - 10}장은 제외됩니다.",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text("확인"),
              ),
            ],
          ),
        );
      });
      print('팝업창이 안 뜬다!!');
    } else {
      print('이미지 정상');
      _limitedImages = widget.imagePaths;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: ListView(
        children: [
          PostFormHeader(username: 'username'),
          PostFormImage(imagePaths: _limitedImages),
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
      title: Text('업로드'),
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
