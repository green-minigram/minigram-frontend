import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';

class MButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final double? textSize;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final BorderSide? borderSide;

  // 기본 생성자 (보더 없는 버튼)
  const MButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.textSize,
    this.borderRadius,
    this.padding,
  }) : borderSide = null,
       super(key: key);

  // outline named constructor
  const MButton.outline({
    Key? key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.textSize,
    this.borderRadius,
    this.padding,
    required this.borderSide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 실제 렌더링 시점에 디자인 상수 대입
    final double usedTextSize = textSize ?? MSize.kFont.m;
    final double usedBorderRadius = borderRadius ?? MSize.kBorderRadius.m;
    final EdgeInsetsGeometry usedPadding =
        padding ?? EdgeInsets.symmetric(horizontal: MSize.kGap.l, vertical: MSize.kGap.m);

    final bgColor = backgroundColor ?? MColor.kButton.primary;
    final defaultTextColor = textColor ?? MColor.kNormal.white;

    if (borderSide != null) {
      return OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: defaultTextColor,
          side: borderSide!,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(usedBorderRadius),
          ),
          padding: usedPadding,
        ),
        onPressed: onPressed,
        child: Text(text, style: TextStyle(fontSize: usedTextSize)),
      );
    } else {
      return FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: defaultTextColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(usedBorderRadius),
          ),
          padding: usedPadding,
        ),
        onPressed: onPressed,
        child: Text(text, style: TextStyle(fontSize: usedTextSize)),
      );
    }
  }
}
