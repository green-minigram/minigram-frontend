import 'package:flutter/material.dart';

class MButton extends StatelessWidget {
  final VoidCallback onPressed; // 버튼 눌림 이벤트 (필수)
  final Widget child; // 버튼 내용 (필수)
  final Color? backgroundColor; // 배경색 (선택적)
  final Color? textColor; // 텍스트 색상 (선택적)
  final double borderRadius; // 모서리 둥글기 (기본값 있음)
  final EdgeInsetsGeometry padding; // 내부 여백 (기본값 있음)
  final BorderSide? borderSide; // 보더 속성

  // 기본 생성자 (보더 없는 버튼)
  const MButton({
    Key? key,
    required this.onPressed, // 필수 매개변수
    required this.child, // 필수 매개변수
    this.backgroundColor, // 선택적 - null이면 기본값 사용
    this.textColor, // 선택적 - null이면 기본값 사용
    this.borderRadius = 15.0, // 기본값: 15.0
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0), // 기본 패딩
  }) : borderSide = null,
       // 기본 생성자는 항상 보더 없음
       super(key: key);

  // Named 생성자 .outline (보더 있는 버튼)
  const MButton.outline({
    Key? key,
    required this.onPressed, // 필수 매개변수
    required this.child, // 필수 매개변수
    this.backgroundColor, // 선택적 - null이면 기본값 사용
    this.textColor, // 선택적 - null이면 기본값 사용
    this.borderRadius = 15.0, // 기본값: 15.0
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0), // 기본 패딩
    required this.borderSide, // outline에서는 보더가 필수!
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? Color(0xFF4A5EF9); // 기본 배경색
    final defaultTextColor = textColor ?? Colors.white; // 기본 텍스트 색상

    if (borderSide != null) {
      // 보더가 있는 경우 - OutlinedButton 사용
      return OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: defaultTextColor,
          side: borderSide!,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: padding,
        ),
        onPressed: onPressed,
        child: child,
      );
    } else {
      // 보더가 없는 경우 - FilledButton 사용 (그림자 없음!)
      return FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: defaultTextColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          padding: padding,
          // elevation 설정 불필요! FilledButton은 기본적으로 elevation: 0
        ),
        onPressed: onPressed,
        child: child,
      );
    }
  }
}
