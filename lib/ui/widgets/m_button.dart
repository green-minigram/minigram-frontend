import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';

class MButton extends StatelessWidget {
  final VoidCallback? onPressed; // 로딩/비활성 시 null 허용
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final double? textSize;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final BorderSide? borderSide;
  final bool isLoading; // 로딩 중 여부
  final bool disabled; // 외부에서 강제 비활성화 -> 추가제어가 필요하면 사용. 근데 필요없을듯

  // 기본 생성자 (보더 없는 버튼)
  const MButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.disabled = false,
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
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.disabled = false,
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

    // 로딩이거나 disabled면 onPressed를 null로 만들어 머티리얼 비활성 스타일 적용
    final bool isDisabled = isLoading || disabled;
    final VoidCallback? effectiveOnPressed = isDisabled ? null : onPressed;

    final Widget child = isLoading
        ? SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(defaultTextColor),
            ),
          )
        : Text(text, style: TextStyle(fontSize: usedTextSize));

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
        onPressed: effectiveOnPressed,
        child: child,
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
        onPressed: effectiveOnPressed,
        child: child,
      );
    }
  }
}
