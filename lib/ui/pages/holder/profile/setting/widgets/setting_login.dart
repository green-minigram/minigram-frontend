import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/ui/widgets/m_show_alert_dialog.dart';

class SettingLogin extends StatelessWidget {
  const SettingLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "로그인",
          style: TextStyle(color: MColor.kText.description, fontWeight: FontWeight.bold, fontSize: MSize.kFont.m),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          onTap: () {
            MShowAlertDialog.show(
              context,
              title: "계정에서 로그아웃하시겠어요?",
              failText: "취소",
              successText: "확인",
              onFail: () {
                print("로그아웃 취소됨");
              },
              onSuccess: () {
                print("로그아웃 실행");
                // 로그아웃 로직 실행
              },
            );
          },
          title: Text(
            "로그아웃",
            style: TextStyle(fontSize: MSize.kFont.l, fontWeight: FontWeight.bold, color: MColor.kText.red),
          ),
        ),
      ],
    );
  }
}
