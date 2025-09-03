import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';

class MAuthTextFormField extends StatelessWidget {
  final String? title;
  final String hintText;
  final String errorText;
  final Function(String)? onChanged;
  final Future<void> Function()? onTap;
  final bool obscureText;
  final TextInputType keyboardType;

  const MAuthTextFormField({
    this.title,
    required this.hintText,
    this.errorText = "",
    this.onChanged,
    this.onTap,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: TextStyle(fontSize: MSize.kFont.xxl),
          ),
          SizedBox(height: MSize.kGap.xl),
        ],
        TextFormField(
          onTap: onTap,
          obscureText: obscureText,
          onChanged: onChanged,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: MColor.kText.secondary),
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
