import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';
import 'package:minigram/data/gvm/session_gvm.dart';
import 'package:minigram/ui/widgets/m_show_alert_dialog.dart';

class SettingLogin extends ConsumerWidget {
  const SettingLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "로그인",
          style: TextStyle(
            color: MColor.kText.description,
            fontWeight: FontWeight.bold,
            fontSize: MSize.kFont.m,
          ),
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
                ref.read(sessionProvider.notifier).logout();
              },
            );
          },
          title: Text(
            "로그아웃",
            style: TextStyle(
              fontSize: MSize.kFont.l,
              fontWeight: FontWeight.bold,
              color: MColor.kText.red,
            ),
          ),
        ),
      ],
    );
  }
}
