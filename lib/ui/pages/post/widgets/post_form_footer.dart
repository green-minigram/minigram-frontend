import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';

class PostFormFooter extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onSubmit;

  const PostFormFooter({
    super.key,
    required this.controller,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MSize.kGap.l),
      child: TextField(
        controller: controller,
        maxLines: null,
        // 여러 줄 입력 가능
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          hintText: "게시글 입력...",
          hintStyle: TextStyle(color: MColor.kText.secondary),
          border: InputBorder.none,
        ),
        style: TextStyle(
          fontSize: MSize.kFont.normal,
          color: MColor.kText.normal,
        ),
        onSubmitted: (_) => onSubmit?.call(),
      ),
    );
  }
}
