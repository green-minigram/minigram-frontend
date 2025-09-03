import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';

class MAuthTextFormField extends StatelessWidget {
  final String title;
  final String hintText;
  final String errorText;
  final Function(String)? onChanged;
  final bool obscureText;
  final bool disableTitle;
  final TextInputType keyboardType;

  const MAuthTextFormField({
    required this.title,
    required this.hintText,
    this.errorText = "",
    this.onChanged,
    this.obscureText = false,
    this.disableTitle = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!disableTitle) ...[
          Text(
            title,
            style: TextStyle(fontSize: MSize.kFont.xxl),
          ),
          SizedBox(height: MSize.kGap.xl),
        ],
        TextFormField(
          obscureText: obscureText,
          onChanged: onChanged,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            errorText: errorText.isEmpty ? null : errorText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(MSize.kBorderRadius.m),
              borderSide: BorderSide(color: MColor.kText.secondary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(MSize.kBorderRadius.m),
              borderSide: BorderSide(color: MColor.kText.normal),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(MSize.kBorderRadius.m),
              borderSide: BorderSide(color: MColor.kText.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(MSize.kBorderRadius.m),
              borderSide: BorderSide(color: MColor.kText.red),
            ),
          ),
        ),
      ],
    );
  }
}
