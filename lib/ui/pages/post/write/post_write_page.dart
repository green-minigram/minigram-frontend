import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/pages/post/widgets/post_form_footer.dart';
import 'package:minigram/ui/pages/post/widgets/post_form_header.dart';
import 'package:minigram/ui/pages/post/widgets/post_form_image.dart';
import 'package:minigram/ui/pages/post/write/widgets/post_date_picker.dart';

class PostWritePage extends StatefulWidget {
  final List<String> imagePaths;
  final bool isAdmin; // TODO userRole로 교체해야 합니다

  const PostWritePage({
    super.key,
    required this.imagePaths,
    this.isAdmin = true,
  });

  @override
  State<PostWritePage> createState() => _PostWritePageState();
}

class _PostWritePageState extends State<PostWritePage> {
  final TextEditingController _textController = TextEditingController();
  late List<String> _limitedImages;

  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();

    if (widget.imagePaths.length > 10) {
      _limitedImages = widget.imagePaths.take(10).toList();

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
                child: const Text("확인"),
              ),
            ],
          ),
        );
      });
    } else {
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

          if (widget.isAdmin) ...[
            PostDatePicker(
              label: "시작일",
              selectedDate: _startDate,
              onDateChanged: (date) => setState(() => _startDate = date),
            ),
            PostDatePicker(
              label: "종료일",
              selectedDate: _endDate,
              onDateChanged: (date) => setState(() => _endDate = date),
            ),
            const Divider(),
          ],

          PostFormFooter(
            controller: _textController,
            onSubmit: () {
              print("입력한 내용: ${_textController.text}");
              print("시작날짜: $_startDate");
              print("끝날짜: $_endDate");
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
            print("시작날짜: $_startDate");
            print("끝날짜: $_endDate");
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
