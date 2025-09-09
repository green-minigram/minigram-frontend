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

  Future<void> _handleAlert(BuildContext context) async {
    final result = await _showAlertDialog(context);

    switch (result) {
      case true:
        // Yes를 선택했을 때
        print('사용자가 Yes를 선택했습니다');
        break;
      case false:
        // No를 선택했을 때
        print('사용자가 No를 선택했습니다');
        break;
      case null:
        // 다이얼로그가 취소되었을 때
        print('다이얼로그가 취소되었습니다');
        break;
    }
  }

  Future<bool?> _showAlertDialog(BuildContext context) async {
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false, // 배경 터치해도 안사라짐
      builder: (BuildContext context) {
        return SimpleDialog(
          backgroundColor: MColor.kBackGround.normal,
          title: Text(
            "계정에서 ?",
            textAlign: TextAlign.center,
          ),
          children: <Widget>[
            // 메시지 표시
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Text(
                "내용?",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),

            // No 버튼
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text(
                'No',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Yes 버튼 (destructive)
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text(
                'Yes',
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );
  }
}
