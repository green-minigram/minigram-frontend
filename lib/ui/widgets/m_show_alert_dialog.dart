import 'package:flutter/material.dart';
import 'package:minigram/_core/styles/m_color.dart';
import 'package:minigram/_core/styles/m_size.dart';

class MShowAlertDialog {
  static Future<void> show(
    BuildContext context, { // 컨택스트 필요
    required String title, // 제목 필요
    String? content, // 내용
    required String failText, // 취소 버튼 제목
    required String successText, // 성공 버튼 제목
    required VoidCallback onFail, // 취소 콜백
    required VoidCallback onSuccess, // 성공 콜백
    Color? backgroundColor, // 배경색 - 기본값 흰색
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MSize.kBorderRadius.m)),
          contentPadding: EdgeInsets.fromLTRB(0, MSize.kGap.l, 0, 0),
          insetPadding: EdgeInsets.symmetric(horizontal: 60),
          backgroundColor: backgroundColor ?? MColor.kBackGround.normal,
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: MSize.kFont.m, fontWeight: FontWeight.bold),
          ),
          children: <Widget>[
            if (content != null) ...[
              Padding(
                padding: EdgeInsets.only(bottom: MSize.kGap.huge, right: MSize.kGap.l, left: MSize.kGap.l),
                child: Text(
                  content!,
                  style: TextStyle(fontSize: MSize.kFont.normal),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            Divider(
              height: 0.5,
              thickness: 1,
              color: MColor.kLine.gray,
            ),
            SimpleDialogOption(
              padding: EdgeInsets.symmetric(vertical: MSize.kGap.m),
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(
                successText,
                style: TextStyle(
                  fontSize: MSize.kFont.m,
                  fontWeight: FontWeight.bold,
                  color: MColor.kText.red,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Divider(
              height: 0.5,
              thickness: 1,
              color: MColor.kLine.gray,
            ),
            SimpleDialogOption(
              padding: EdgeInsets.symmetric(vertical: MSize.kGap.m),
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(
                failText,
                style: TextStyle(
                  fontSize: MSize.kFont.m,
                  color: MColor.kText.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        );
      },
    );

    switch (result) {
      case true:
        onSuccess();
        break;
      case false:
        onFail();
        break;
      case null:
        // 다이얼로그 취소됨
        break;
    }
  }
}
