import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';

class MAuthTextFormField extends StatelessWidget {
  final String title;
  final String errorText;
  final Function(String)? onChanged;
  final bool obscureText;
  final bool disableTitle;

  const MAuthTextFormField({
    required this.title,
    this.errorText = "",
    this.onChanged,
    this.obscureText = false,
    this.disableTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: MSizes.kFont.xxl),
        ),
        SizedBox(height: MSizes.kGap.xl),
        TextFormField(
          obscureText: obscureText,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: "${title}을 입력해주세요",
            errorText: errorText.isEmpty ? null : errorText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(MSizes.kBorderRadius.m),
              borderSide: BorderSide(color: MColor.kText.secondary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(MSizes.kBorderRadius.m),
              borderSide: BorderSide(color: MColor.kText.normal),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(MSizes.kBorderRadius.m),
              borderSide: BorderSide(color: MColor.kText.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(MSizes.kBorderRadius.m),
              borderSide: BorderSide(color: MColor.kText.red),
            ),
          ),
        ),
      ],
    );
  }
}
