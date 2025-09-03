import 'package:flutter/material.dart';

// PreferredSizeWidget을 상속받아 AppBar처럼 사용할 수 있는 커스텀 Appbar 위젯을 정의합니다.
class FormAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final VoidCallback? onLeadingPressed;

  // 생성자를 통해 제목과 뒤로 가기 버튼의 동작을 외부에서 주입받습니다.
  const FormAppBar({
    Key? key,
    required this.titleText,
    this.onLeadingPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titleText),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: onLeadingPressed, // 외부에서 주입된 함수를 실행합니다.
      ),
    );
  }

  // AppBar의 높이를 지정하기 위해 PreferredSizeWidget의 required getter를 구현합니다.
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
