import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/widgets/m_text_field_loading_indicator.dart';

class MAuthTextFormField extends StatelessWidget {
  final String? title;
  final String hintText;
  final String errorText;
  final Function(String)? onChanged;
  final Future<void> Function()? onTap;
  final bool obscureText;
  final TextInputType keyboardType;

  // 추가: 상태 아이콘 제어용
  final bool showStatusIcon; // 상태 아이콘 노출 여부(기본 true)
  final bool isChecking; // 서버 중복체크 로딩 중
  final bool? isAvailable; // null=미확정, true=가용, false=중복
  final VoidCallback? onSuffixTap; // 아이콘 탭 액션(옵션)

  const MAuthTextFormField({
    this.title,
    required this.hintText,
    this.errorText = "",
    this.onChanged,
    this.onTap,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.showStatusIcon = true,
    this.isChecking = false,
    this.isAvailable, // 기본 null
    this.onSuffixTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasError = errorText.isNotEmpty;

    Widget? suffix;
    if (showStatusIcon) {
      if (isChecking) {
        // 로딩 인디케이터
        suffix = MTextFieldLoadingIndicator();
      } else if (!hasError && isAvailable == true) {
        // 성공(초록 체크)
        suffix = TextFieldCheckIcon(
          icon: Icons.check_circle_outline_rounded,
          color: MColor.kIcon.green,
        );
      } else if (isAvailable == false) {
        // 중복(경고)
        suffix = TextFieldCheckIcon(
          icon: Icons.error_outline,
          color: MColor.kIcon.red,
        );
      } else {
        suffix = null;
      }

      // 우측 아이콘에 온탭 이벤트 사용할지
      if (suffix != null && onSuffixTap != null) {
        suffix = InkWell(onTap: onSuffixTap, child: suffix);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(title!, style: TextStyle(fontSize: MSize.kFont.xxl)),
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
            // 핵심: 상태 아이콘
            suffixIcon: suffix == null
                ? null
                : Padding(
                    padding: const EdgeInsetsDirectional.only(end: 8.0),
                    child: suffix,
                  ),
            // 아이콘 여백/높이 최적화
            isDense: true,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 24,
              minHeight: 24,
            ),
          ),
        ),
      ],
    );
  }
}

class TextFieldCheckIcon extends StatelessWidget {
  // 1. 필요한 속성을 final 변수로 선언합니다.
  final IconData icon;
  final Color color;
  final double size;

  // 2. 생성자(constructor)를 통해 외부에서 값을 받도록 합니다.
  const TextFieldCheckIcon({
    super.key,
    required this.icon,
    required this.color,
    this.size = 24.0, // 선택 사항: 기본값을 지정해줄 수도 있습니다.
  });

  @override
  Widget build(BuildContext context) {
    // 3. 받은 속성을 Icon 위젯에 적용합니다.
    return Icon(
      icon,
      color: color,
      size: size,
    );
  }
}
